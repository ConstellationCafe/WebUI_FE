import 'package:constellation_cafe/shared/widgets/usage/painter/hold_painter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../router/router_provider.dart';
import 'usage_content.dart';
import 'usage_step.dart';

class Usage extends StatefulWidget {
  final Widget child;
  final String usageKey;
  final List<UsageStep> steps;

  const Usage({
    super.key,
    required this.child,
    required this.usageKey,
    required this.steps,
  });

  @override
  State<Usage> createState() => _UsageState();
}

class _UsageState extends State<Usage> with RouteAware {
  OverlayEntry? _overlayEntry;
  int currentStep = 0;

  static const double _gap = 40;
  static const double _contentHeight = 120.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShow();
    });
  }

  Future<void> _checkAndShow() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool(widget.usageKey) ?? false;

    if (!mounted || shown) return;

    _showStep();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);

    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _removeOverlay();
    super.dispose();
  }

  @override
  void didPushNext() {
    _removeOverlay();
  }

  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showStep();
      }
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _prevStep() {
    if (currentStep == 0) return;

    currentStep--;
    _removeOverlay();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showStep();
      }
    });
  }

  Future<void> _nextStep() async {
    _removeOverlay();

    if (currentStep < widget.steps.length - 1) {
      currentStep++;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showStep();
        }
      });

      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      await prefs.setBool(widget.usageKey, true);
    }
  }

  void _showStep() {
    if (!mounted || _overlayEntry != null) return;
    if (widget.steps.isEmpty) return;

    final step = widget.steps[currentStep];
    final targetContext = step.key.currentContext;

    if (targetContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showStep();
        }
      });
      return;
    }

    final renderObject = targetContext.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showStep();
        }
      });
      return;
    }

    final renderBox = renderObject;
    final size = renderBox.size;

    final overlay = Overlay.of(
      context,
      rootOverlay: true,
    );

    final overlayRenderObject = overlay.context.findRenderObject();

    if (overlayRenderObject is! RenderBox ||
        !overlayRenderObject.hasSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showStep();
        }
      });
      return;
    }

    final offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayRenderObject,
    );

    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    double top = offset.dy + size.height + _gap;

    if (top + _contentHeight >
        screenSize.height - padding.bottom) {
      top = offset.dy - _contentHeight - _gap;
    }

    top = top.clamp(
      padding.top + _gap,
      screenSize.height -
          padding.bottom -
          _contentHeight -
          _gap,
    );

    const minWidth = 200.0;
    const maxWidth = 400.0;

    final width = size.width.clamp(
      minWidth,
      maxWidth,
    );

    double left = offset.dx;

    left = left.clamp(
      8.0,
      screenSize.width - width - 8.0,
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _nextStep,
                  behavior: HitTestBehavior.opaque,
                  child: CustomPaint(
                    painter: HolePainter(
                      rect: Rect.fromLTWH(
                        offset.dx,
                        offset.dy,
                        size.width,
                        size.height,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: top,
                left: left,
                width: width,
                child: UsageContent(
                  message: step.message,
                  onNext: _nextStep,
                  onPrev: _prevStep,
                  isLastStep:
                  currentStep == widget.steps.length - 1,
                  isFirstStep: currentStep == 0,
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);

    // Overlay가 실제로 삽입되고 레이아웃된 다음 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final context = step.key.currentContext;

      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          alignment: 0.5,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}