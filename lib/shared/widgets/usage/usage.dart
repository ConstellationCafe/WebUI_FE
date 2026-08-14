import 'package:constellation_cafe/shared/widgets/usage/constants/usage_constants.dart';
import 'package:constellation_cafe/shared/widgets/usage/painter/hold_painter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/screen_width.dart';
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

class _UsageState extends State<Usage>
    with RouteAware, WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShow();
    });
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
    WidgetsBinding.instance.removeObserver(this);

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

  /// 화면 크기가 변경되었을 때 호출된다.
  ///
  /// 브라우저 리사이즈, 화면 방향 변경,
  /// 모바일 키보드 표시/숨김 등의 상황에서도 호출될 수 있다.
  @override
  void didChangeMetrics() {
    if (!mounted || _overlayEntry == null) {
      return;
    }

    _removeOverlay();
    _scheduleShowStep();
  }

  Future<void> _checkAndShow() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool(widget.usageKey) ?? false;

    if (!mounted || shown) {
      return;
    }

    _showStep();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _prevStep() {
    if (currentStep <= 0) {
      return;
    }

    currentStep--;

    _removeOverlay();
    _scheduleShowStep();
  }

  Future<void> _nextStep() async {
    _removeOverlay();

    if (currentStep < widget.steps.length - 1) {
      currentStep++;
      _scheduleShowStep();
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      await prefs.setBool(widget.usageKey, true);
    }
  }

  void _scheduleShowStep() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showStep();
      }
    });
  }

  Future<void> _showStep() async {
    if (!mounted ||
        _overlayEntry != null ||
        widget.steps.isEmpty ||
        currentStep >= widget.steps.length) {
      return;
    }

    final step = widget.steps[currentStep];

    final targetContext = step.key.currentContext;

    if (targetContext == null) {
      _scheduleShowStep();
      return;
    }

    /*
     * 먼저 target을 Scrollable 영역 안에서
     * 화면에 보이도록 이동시킨다.
     *
     * Overlay를 생성하기 전에 스크롤을 처리하기 때문에
     * 스크롤 이후 target과 Overlay의 위치가 어긋나는 것을 방지한다.
     */
    await _ensureTargetVisible(targetContext);

    if (!mounted) {
      return;
    }

    /*
     * 스크롤이 끝난 후 RenderBox를 다시 가져온다.
     *
     * 현재 화면상의 실제 target 위치를 사용한다.
     */
    final renderObject = targetContext.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      _scheduleShowStep();
      return;
    }

    final overlay = Overlay.of(
      context,
      rootOverlay: true,
    );

    final overlayRenderObject = overlay.context.findRenderObject();

    if (overlayRenderObject is! RenderBox ||
        !overlayRenderObject.hasSize) {
      _scheduleShowStep();
      return;
    }

    final renderBox = renderObject;
    final size = renderBox.size;

    final offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayRenderObject,
    );

    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);

    final top = _calculateTop(
      offset: offset,
      screenHeight: screenSize.height,
      topPadding: padding.top,
      bottomPadding: padding.bottom,
    );

    final deviceType = ScreenWidth.widthChecker(
      screenSize.width,
    );

    final isMobile = deviceType == ScreenWidth.mobile;

    final width = isMobile
        ? screenSize.width -
        (UsageConstants.screenHorizontalPadding * 2)
        : size.width.clamp(
      UsageConstants.minContentWidth,
      UsageConstants.maxContentWidth,
    );

    final left = _calculateLeft(
      offset: offset,
      screenWidth: screenSize.width,
      contentWidth: width,
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
  }

  Future<void> _ensureTargetVisible(
      BuildContext targetContext,
      ) async {
    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(
        milliseconds:
        UsageConstants.scrollDurationMilliseconds,
      ),
      alignment: 0.5,
      curve: Curves.easeInOut,
    );
  }

  double _calculateTop({
    required Offset offset,
    required double screenHeight,
    required double topPadding,
    required double bottomPadding,
  }) {
    double top =
        offset.dy + UsageConstants.contentGap;

    if (top + UsageConstants.contentHeight >
        screenHeight - bottomPadding) {
      top = offset.dy -
          UsageConstants.contentHeight -
          UsageConstants.contentGap;
    }

    return top.clamp(
      topPadding + UsageConstants.contentGap,
      screenHeight -
          bottomPadding -
          UsageConstants.contentHeight -
          UsageConstants.contentGap,
    );
  }

  double _calculateLeft({
    required Offset offset,
    required double screenWidth,
    required double contentWidth,
  }) {
    return offset.dx.clamp(
      UsageConstants.screenHorizontalPadding,
      screenWidth -
          contentWidth -
          UsageConstants.screenHorizontalPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}