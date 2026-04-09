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

  void _showStep() {
    final step = widget.steps[currentStep];

    final renderBox =
        step.key.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _nextStep,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _HolePainter(
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

    Overlay.of(context).insert(_overlayEntry!);
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
      await prefs.setBool(widget.usageKey, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}