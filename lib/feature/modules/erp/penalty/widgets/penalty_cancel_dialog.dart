import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_log.dart';

class PenaltyCancelDialog extends StatefulWidget {
  final PenaltyLog log;
  final Future<bool> Function(String) onSubmit;

  const PenaltyCancelDialog({
    super.key,
    required this.log,
    required this.onSubmit,
  });

  @override
  State<PenaltyCancelDialog> createState() => _PenaltyCancelDialogState();
}

class _PenaltyCancelDialogState extends State<PenaltyCancelDialog> {
  final _form = GlobalKey<FormState>();
  final _reason = TextEditingController();
  bool _submitting = false;
  bool _uncertain = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_submitting,
    child: AlertDialog(
      scrollable: true,
      title: const Text(PenaltyStrings.cancelPenalty),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.log.targetUsername} · ${widget.log.targetDiscordId}',
            ),
            Text(widget.log.reason),
            const SizedBox(height: PenaltyTokens.fieldGap),
            const Text(PenaltyStrings.cancellationNotice),
            const SizedBox(height: PenaltyTokens.fieldGap),
            TextFormField(
              controller: _reason,
              autofocus: true,
              enabled: !_submitting && !_uncertain,
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: PenaltyStrings.reason,
              ),
              validator: (value) =>
                  (value ?? '').trim().isNotEmpty && (value ?? '').length <= 255
                  ? null
                  : PenaltyStrings.invalidReason,
            ),
            if (_uncertain) const Text(PenaltyStrings.cancelFailed),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _submitting ? null : () => Navigator.pop(context, false),
          child: const Text(PenaltyStrings.cancel),
        ),
        ElevatedButton(
          onPressed: _submitting || _uncertain ? null : _submit,
          child: _submitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(PenaltyStrings.cancelPenalty),
        ),
      ],
    ),
  );

  Future<void> _submit() async {
    if (_submitting || _uncertain || !_form.currentState!.validate()) return;
    setState(() => _submitting = true);
    final success = await widget.onSubmit(_reason.text.trim());
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _submitting = false;
        _uncertain = true;
      });
    }
  }
}
