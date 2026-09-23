import 'package:flutter/material.dart';

import '../constants/point_strings.dart';

class PointTransactionDialog extends StatefulWidget {
  final bool isDeposit;
  final Future<bool> Function(int amount, String description) onSubmit;

  const PointTransactionDialog({
    super.key,
    required this.isDeposit,
    required this.onSubmit,
  });

  @override
  State<PointTransactionDialog> createState() => _PointTransactionDialogState();
}

class _PointTransactionDialogState extends State<PointTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.isDeposit ? PointStrings.deposit : PointStrings.withdraw,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _amountController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: PointStrings.amount),
              validator: (value) {
                final amount = int.tryParse(value ?? '');
                return amount == null || amount <= 0
                    ? '1 이상의 금액을 입력하세요.'
                    : null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: PointStrings.description,
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? '내역을 입력하세요.'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text(PointStrings.cancel),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(PointStrings.apply),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final success = await widget.onSubmit(
      int.parse(_amountController.text),
      _descriptionController.text.trim(),
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) Navigator.pop(context);
  }
}
