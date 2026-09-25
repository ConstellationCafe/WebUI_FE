part of 'point_transaction_dialog.dart';

class _PointTransactionDialogState extends State<PointTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    final log = widget.originalLog;
    if (log != null) {
      _amountController.text = log.amount.toString();
      _descriptionController.text = log.description;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isSubmitting,
      child: AlertDialog(
        scrollable: true,
        title: Text(
          widget.originalLog != null
              ? PointStrings.editHistory
              : widget.isDeposit
              ? PointStrings.deposit
              : PointStrings.withdraw,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${widget.member.username} · ${widget.member.discordId}'),
              const SizedBox(height: PointTokens.fieldGap),
              TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _amountController,
                autofocus: true,
                enabled: !_isSubmitting && !_hasError,
                keyboardType: TextInputType.numberWithOptions(
                  signed: widget.originalLog != null,
                ),
                decoration: InputDecoration(
                  labelText: PointStrings.amount,
                  helperText: widget.originalLog != null
                      ? PointStrings.signedAmountHint
                      : null,
                  helperMaxLines: 2,
                ),
                validator: (value) {
                  final amount = int.tryParse(value ?? '');
                  final original = widget.originalLog;
                  if (original != null) {
                    if (amount == null ||
                        amount == 0 ||
                        amount.abs() > 100000000) {
                      return PointStrings.invalidSignedAmount;
                    }
                    final nextBalance =
                        widget.member.coin + amount - original.amount;
                    if (nextBalance < 0 || nextBalance > 2147483647) {
                      return PointStrings.invalidResultingBalance;
                    }
                    return null;
                  }
                  if (amount == null || amount <= 0 || amount > 100000000) {
                    return PointStrings.invalidAmount;
                  }
                  if (!widget.isDeposit && amount > widget.member.coin) {
                    return PointStrings.insufficientBalance;
                  }
                  return null;
                },
              ),
              const SizedBox(height: PointTokens.fieldGap),
              TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _descriptionController,
                maxLength: 255,
                enabled: !_isSubmitting && !_hasError,
                decoration: const InputDecoration(
                  labelText: PointStrings.description,
                ),
                validator: (value) {
                  if ((value ?? '').length > 255) {
                    return PointStrings.invalidDescription;
                  }
                  if (widget.originalLog == null &&
                      (value ?? '').trim().isEmpty) {
                    return PointStrings.descriptionRequired;
                  }
                  return null;
                },
              ),
              if (_hasError) const Text(PointStrings.transactionFailed),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _isSubmitting ? null : () => Navigator.pop(context),
            child: const Text(PointStrings.cancel),
          ),
          ElevatedButton(
            onPressed: _isSubmitting || _hasError ? null : _submit,
            child: _isSubmitting
                ? SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                : const Text(PointStrings.apply),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting || _hasError) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    bool success;
    try {
      success = await widget.onSubmit(
        int.parse(_amountController.text),
        _descriptionController.text.trim(),
      );
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
