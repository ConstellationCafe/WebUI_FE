import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './hold_painter.dart';

class UsageStep {
  final GlobalKey key;
  final String message;

  UsageStep({required this.key, required this.message});
}

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

class _UsageState extends State<Usage> {
  OverlayEntry? _overlayEntry;
  int currentStep = 0;

  @override
  void initState() {
    print("initState");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("addPostFrameCallback");
      _checkAndShow();
    });
  }

  Future<void> _checkAndShow() async {
    print("_checkAndShow");
    _showStep();
    // final prefs = await SharedPreferences.getInstance();
    // final shown = prefs.getBool(widget.usageKey) ?? false;
    //
    // if (!shown) {
    //   _showStep();
    // }
  }

  void _showStep() {
    if (_overlayEntry != null) return;

    final step = widget.steps[currentStep];

    print("a");
    final targetContext = step.key.currentContext;
    if (targetContext == null) {
      Future.delayed(const Duration(milliseconds: 100), _showStep);
      return;
    }

    print("b");
    final renderBox = targetContext.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      Future.delayed(const Duration(milliseconds: 100), _showStep);
      return;
    }

    print("c");
    final size = renderBox.size;

    final overlay = Overlay.of(this.context, rootOverlay: true);

    final offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay.context.findRenderObject(),
    );

    print("d");
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _nextStep,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(
                size: overlay.context.size ?? MediaQuery.of(context).size,
                painter: HolePainter(
                  rect: Rect.fromLTWH(
                    offset.dx,
                    offset.dy,
                    size.width,
                    size.height,
                  ),
                ),
              ),
              Positioned(
                top: offset.dy + size.height + 16,
                left: 24,
                right: 24,
                child: _messageBox(step.message),
              ),
            ],
          ),
        ),
      ),
    );

    print("insert");
    overlay.insert(_overlayEntry!);
  }

  Widget _messageBox(String message) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _nextStep,
              child: Text(currentStep == widget.steps.length - 1
                  ? '확인'
                  : '다음'),
            )
          ],
        ),
      ),
    );
  }

  void _nextStep() async {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (currentStep < widget.steps.length - 1) {
      currentStep++;
      _showStep();
    } else {
      final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool(widget.usageKey, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
