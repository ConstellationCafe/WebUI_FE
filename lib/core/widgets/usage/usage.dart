import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './hold_painter.dart';
import './usage_content.dart';
import '../../routes/router_provider.dart'; // RouteObserver 임포트

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

class _UsageState extends State<Usage> with RouteAware {
  OverlayEntry? _overlayEntry;
  int currentStep = 0;

  Size? _lastSize; // 👈 화면 크기 추적

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShow();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // RouteObserver 구독
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }

    // 🔥 route / MediaQuery 변경 대응
    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rebuildOverlay();
      });
    }
  }

  @override
  void didUpdateWidget(covariant Usage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 🔥 widget rebuild 대응
    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rebuildOverlay();
      });
    }
  }

  Future<void> _checkAndShow() async {
    _showStep();
    // final prefs = await SharedPreferences.getInstance();
    // final shown = prefs.getBool(widget.usageKey) ?? false;
    //
    // if (!shown) {
    //   _showStep();
    // }
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
    // 새로운 화면이 위에 푸시될 때 오버레이 숨기기
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didPopNext() {
    // 위에 있던 화면이 팝되고 다시 이 화면이 보일 때 오버레이 복구
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

    _overlayEntry?.remove();
    _overlayEntry = null;

    currentStep--;
    _showStep();
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

  void _showStep() {
    if (_overlayEntry != null) return;

    final step = widget.steps[currentStep];

    final targetContext = step.key.currentContext;

    // 🔥 target 사라지면 overlay 종료
    if (targetContext == null) {
      return;
    }

    final renderBox = targetContext.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      Future.delayed(const Duration(milliseconds: 100), _showStep);
      return;
    }

    final size = renderBox.size;

    final overlay = Overlay.of(this.context, rootOverlay: true);

    final offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay.context.findRenderObject(),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _nextStep,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              // 🔥 어두운 배경 + hole
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

              // 🔥 설명 UI (타겟 바로 아래)
              Positioned(
                top: offset.dy + size.height + 12,
                left: offset.dx,
                width: size.width.clamp(200, 400),
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
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    // 🔥 화면 크기 변경 감지
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