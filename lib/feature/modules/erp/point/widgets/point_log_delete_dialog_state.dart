part of 'point_log_delete_dialog.dart';

class _PointLogDeleteDialogState extends State<PointLogDeleteDialog> {
  bool _isSubmitting = false;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final balanceAfter = widget.member.coin - widget.log.amount;
    final validBalance = balanceAfter >= 0 && balanceAfter <= 2147483647;
    final number = NumberFormat.decimalPattern();

    return PopScope(
      canPop: !_isSubmitting,
      child: AlertDialog(
        scrollable: true,
        title: const Text(PointStrings.deleteHistory),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.member.username} · ${widget.member.discordId}'),
            const SizedBox(height: PointTokens.fieldGap),
            Text(
              widget.log.description.trim().isEmpty
                  ? PointStrings.noDescription
                  : widget.log.description,
            ),
            Text(
              DateFormat('yyyy.MM.dd HH:mm').format(widget.log.at.toLocal()),
            ),
            Text('${number.format(widget.log.amount)} P'),
            const SizedBox(height: PointTokens.fieldGap),
            const Text(PointStrings.deleteConfirmation),
            Text(
              '${PointStrings.balanceAfter}: ${number.format(balanceAfter)} P',
            ),
            if (!validBalance) const Text(PointStrings.invalidResultingBalance),
            if (_hasError) const Text(PointStrings.transactionFailed),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: _isSubmitting ? null : () => Navigator.pop(context),
            child: const Text(PointStrings.cancel),
          ),
          ElevatedButton(
            onPressed: _isSubmitting || _hasError || !validBalance
                ? null
                : _submit,
            child: _isSubmitting
                ? SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                : const Text(PointStrings.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting || _hasError) return;
    setState(() => _isSubmitting = true);
    bool success;
    try {
      success = await widget.onSubmit();
    } catch (_) {
      success = false;
    }
    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _hasError = !success;
    });
    if (success) Navigator.pop(context, true);
  }
}
