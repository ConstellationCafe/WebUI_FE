import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/penalty_formats.dart';
import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../data/dto/request/penalty_create_request.dart';
import '../domain/new_penalty_request_id.dart';
import '../domain/penalty_input_rules.dart';
import 'penalty_id_input_formatters.dart';

class PenaltyAwardDialog extends StatefulWidget {
  final Future<bool> Function(PenaltyCreateRequest) onSubmit;
  final String? initialDiscordId;

  /// 발생 시각이 미래인지 판단할 때 쓰는 현재 시각. 테스트에서 주입한다.
  final DateTime Function() clock;

  const PenaltyAwardDialog({
    super.key,
    required this.onSubmit,
    this.initialDiscordId,
    this.clock = DateTime.now,
  });

  @override
  State<PenaltyAwardDialog> createState() => _PenaltyAwardDialogState();
}

class _PenaltyAwardDialogState extends State<PenaltyAwardDialog> {
  final _form = GlobalKey<FormState>();
  final _requestId = newPenaltyRequestId();
  final _target = TextEditingController();
  final _channel = TextEditingController();
  final _channelName = TextEditingController();
  final _reason = TextEditingController();
  final _occurredAt = TextEditingController();
  bool _submitting = false;
  bool _uncertain = false;

  @override
  void initState() {
    super.initState();
    _target.text = widget.initialDiscordId ?? '';
  }

  @override
  void dispose() {
    _target.dispose();
    _channel.dispose();
    _channelName.dispose();
    _reason.dispose();
    _occurredAt.dispose();
    super.dispose();
  }

  DateTime? _parseOccurredAt() {
    if (_occurredAt.text.trim().isEmpty) return null;
    try {
      return DateFormat(
        PenaltyFormats.occurredAtInput,
      ).parseStrict(_occurredAt.text.trim());
    } on FormatException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_submitting,
    child: AlertDialog(
      scrollable: true,
      title: const Text(PenaltyStrings.award),
      content: SizedBox(
        width: PenaltyTokens.dialogWidth,
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _target,
                autofocus: true,
                enabled: !_submitting && !_uncertain,
                keyboardType: TextInputType.number,
                inputFormatters: penaltyIdInputFormatters(),
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.targetId,
                ),
                validator: (value) =>
                    PenaltyInputRules.discordIdPattern.hasMatch(value ?? '')
                    ? null
                    : PenaltyStrings.invalidId,
              ),
              const SizedBox(height: PenaltyTokens.fieldGap),
              TextFormField(
                controller: _channel,
                enabled: !_submitting && !_uncertain,
                keyboardType: TextInputType.number,
                inputFormatters: penaltyIdInputFormatters(),
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.channelId,
                ),
                validator: (value) =>
                    PenaltyInputRules.discordIdPattern.hasMatch(value ?? '')
                    ? null
                    : PenaltyStrings.invalidId,
              ),
              const SizedBox(height: PenaltyTokens.fieldGap),
              TextFormField(
                controller: _channelName,
                enabled: !_submitting && !_uncertain,
                maxLength: PenaltyInputRules.channelNameMaxLength,
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.channelName,
                ),
                validator: (value) =>
                    (value ?? '').length <=
                        PenaltyInputRules.channelNameMaxLength
                    ? null
                    : PenaltyStrings.invalidChannelName,
              ),
              const SizedBox(height: PenaltyTokens.fieldGap),
              TextFormField(
                controller: _reason,
                enabled: !_submitting && !_uncertain,
                maxLength: PenaltyInputRules.reasonMaxLength,
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.reason,
                ),
                validator: (value) =>
                    (value ?? '').trim().isNotEmpty &&
                        (value ?? '').length <=
                            PenaltyInputRules.reasonMaxLength
                    ? null
                    : PenaltyStrings.invalidReason,
              ),
              const SizedBox(height: PenaltyTokens.fieldGap),
              TextFormField(
                controller: _occurredAt,
                enabled: !_submitting && !_uncertain,
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.occurredAt,
                  hintText: PenaltyStrings.occurredAtHint,
                ),
                validator: (value) =>
                    (value ?? '').trim().isEmpty ||
                        (_parseOccurredAt() != null &&
                            !_parseOccurredAt()!.isAfter(widget.clock()))
                    ? null
                    : PenaltyStrings.invalidOccurredAt,
              ),
              const SizedBox(height: PenaltyTokens.fieldGap),
              const Text(PenaltyStrings.fixedScore),
              if (_uncertain) ...[
                const SizedBox(height: PenaltyTokens.fieldGap),
                const Text(PenaltyStrings.submitFailed),
              ],
            ],
          ),
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
                  dimension: PenaltyTokens.progressIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth: PenaltyTokens.progressIndicatorStrokeWidth,
                  ),
                )
              : const Text(PenaltyStrings.award),
        ),
      ],
    ),
  );

  Future<void> _submit() async {
    if (_submitting || _uncertain || !_form.currentState!.validate()) return;
    setState(() => _submitting = true);
    final success = await widget.onSubmit(
      PenaltyCreateRequest(
        requestId: _requestId,
        targetDiscordId: _target.text,
        channelId: _channel.text,
        channelName: _channelName.text.trim().isEmpty
            ? null
            : _channelName.text.trim(),
        reason: _reason.text.trim(),
        occurredAt: _parseOccurredAt(),
      ),
    );
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
