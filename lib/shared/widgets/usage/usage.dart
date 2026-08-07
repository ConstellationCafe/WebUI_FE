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
  Size? _lastSize;

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

    if (!shown) {
      _showStep();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }

    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rebuildOverlay();
      });
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  void didPushNext() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showStep();
    });
  }

  void _rebuildOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showStep();
  }

  void _prevStep() {
    if (currentStep == 0) return;

    currentStep--;
    _overlayEntry?.remove();
    _overlayEntry = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showStep();
    });
  }

  void _nextStep() async {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (currentStep < widget.steps.length - 1) {
      currentStep++;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showStep();
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(widget.usageKey, true);
    }
  }

  void _showStep() {
    if (_overlayEntry != null) return;

    final step = widget.steps[currentStep];
    final targetContext = step.key.currentContext;

    if (targetContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showStep();
      });
      return;
    }

    final renderBox = targetContext.findRenderObject() as RenderBox?;

    if (renderBox == null || !renderBox.hasSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showStep();
      });
      return;
    }

    final size = renderBox.size;
    final overlay = Overlay.of(context, rootOverlay: true);

    final offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay.context.findRenderObject(),
    );

    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    // 🔥 위치 계산 (gap 적용)
    double top = offset.dy + size.height + _gap;

    if (top + _contentHeight > screenSize.height - padding.bottom) {
      top = offset.dy - _contentHeight - _gap;
    }

    top = top.clamp(
      padding.top + _gap,
      screenSize.height - padding.bottom - _contentHeight - _gap, // 하단 여유 20 추가
    );

    double left = offset.dx;
    const minWidth = 200.0;
    const maxWidth = 400.0;

    final width = size.width.clamp(minWidth, maxWidth);

    left = left.clamp(
      8.0,
      screenSize.width - width - 8.0,
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // 🔥 배경 터치 처리
            Positioned.fill(
              child: GestureDetector(
                onTap: _nextStep,
                behavior: HitTestBehavior.opaque,
                child: CustomPaint(
                  size: overlay.context.size ?? screenSize,
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

            // 🔥 설명 UI
            Positioned(
              top: top,
              left: left,
              width: width,
              child: UsageContent(
                message: step.message,
                onNext: _nextStep,
                onPrev: _prevStep,
                isLastStep: currentStep == widget.steps.length - 1,
                isFirstStep: currentStep == 0,
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);

    // 🔥 overlay 먼저 띄우고 scroll
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 300),
      alignment: 0.5,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    if (_lastSize != currentSize) {
      _lastSize = currentSize;

      if (_overlayEntry != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _rebuildOverlay();
        });
      }
    }

    return widget.child;
  }
}