import 'package:flutter/material.dart';

import '../constants/usage_constants.dart';
import '../painter/hold_painter.dart';
import '../usage_arrow.dart';
import '../usage_content.dart';
import '../usage_step.dart';

class AnimatedOverlay extends StatefulWidget {
  final Rect holeRect;
  final double top;
  final double left;
  final double width;
  final bool isAbove;

  final UsageStep step;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool isLastStep;
  final bool isFirstStep;

  const AnimatedOverlay({
    super.key,
    required this.holeRect,
    required this.top,
    required this.left,
    required this.width,
    required this.isAbove,
    required this.step,
    required this.onNext,
    required this.onPrev,
    required this.isLastStep,
    required this.isFirstStep,
  });

  @override
  State<AnimatedOverlay> createState() => AnimatedOverlayState();
}

class AnimatedOverlayState extends State<AnimatedOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: UsageConstants.overlayAnimationDuration,
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: widget.isAbove
          ? const Offset(0, UsageConstants.overlaySlideOffset) // 위에 있을 때 아래→위
          : const Offset(0, -UsageConstants.overlaySlideOffset), // 아래 있을 때 위→아래
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlay = Overlay.of(context);

    return GestureDetector(
      onTap: widget.onNext,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // 🔥 Hole
            CustomPaint(
              size: overlay.context.size ?? MediaQuery.of(context).size,
              painter: HolePainter(rect: widget.holeRect),
            ),

            // 🔥 Tooltip + Animation
            Positioned(
              top: widget.top,
              left: widget.left,
              width: widget.width,
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!widget.isAbove) const UsageArrow(up: true),
                      UsageContent(
                        message: widget.step.message,
                        onNext: widget.onNext,
                        onPrev: widget.onPrev,
                        isLastStep: widget.isLastStep,
                        isFirstStep: widget.isFirstStep,
                      ),
                      if (widget.isAbove) const UsageArrow(up: false),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
