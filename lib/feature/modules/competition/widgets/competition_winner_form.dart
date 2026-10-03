import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../domain/competition_input_rules.dart';
import '../domain/model/competition_winner.dart';
import 'competition_date_field.dart';

/// 우승 칭호 부여 폼. 입력값과 컨트롤러는 이 위젯의 생명주기와 함께한다.
class CompetitionWinnerForm extends StatefulWidget {
  /// 칭호를 부여할 수 있는 게임 버전. 값은 [GameVersionType]에서만 가져오며,
  /// 현재는 S2만 고를 수 있다. 버전이 늘면 이 목록에 추가한다.
  static const selectableVersions = [GameVersionType.s2];

  final bool isSubmitting;
  final Future<CompetitionWinnerException?> Function(CompetitionWinnerDraft)
  submit;

  /// 오늘 날짜의 기준. 테스트에서 주입한다.
  final DateTime Function() clock;

  const CompetitionWinnerForm({
    super.key,
    required this.isSubmitting,
    required this.submit,
    this.clock = DateTime.now,
  });

  @override
  State<CompetitionWinnerForm> createState() => _CompetitionWinnerFormState();
}

class _CompetitionWinnerFormState extends State<CompetitionWinnerForm> {
  static final _discordId = RegExp(r'^[0-9]{1,20}$');

  final _formKey = GlobalKey<FormState>();
  final _competitionController = TextEditingController();
  final _discordIdController = TextEditingController();
  GameVersionType _version = CompetitionWinnerForm.selectableVersions.first;
  DateTime? _acquisition;
  String? _dateError;
  String? _failureMessage;

  @override
  void dispose() {
    _competitionController.dispose();
    _discordIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = !widget.isSubmitting;
    final failure = _failureMessage;
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              CompetitionStrings.winnerFormSection,
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          TextFormField(
            controller: _competitionController,
            enabled: enabled,
            maxLength: CompetitionInputRules.titleMaxLength,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.winnerCompetitionLabel,
            ),
            validator: _validateCompetitionName,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          TextFormField(
            controller: _discordIdController,
            enabled: enabled,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.winnerDiscordIdLabel,
              helperText: CompetitionStrings.winnerDiscordIdHelper,
            ),
            validator: _validateDiscordId,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          DropdownButtonFormField<GameVersionType>(
            initialValue: _version,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.winnerVersionLabel,
            ),
            items: [
              for (final version in CompetitionWinnerForm.selectableVersions)
                DropdownMenuItem(
                  value: version,
                  child: Text(version.typeToString().toUpperCase()),
                ),
            ],
            onChanged: enabled
                ? (version) {
                    if (version != null) setState(() => _version = version);
                  }
                : null,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          CompetitionDateField(
            label: CompetitionStrings.winnerAcquisitionLabel,
            value: _acquisition,
            enabled: enabled,
            errorText: _dateError,
            clock: widget.clock,
            onChanged: (value) => setState(() {
              _acquisition = value;
              _dateError = null;
            }),
          ),
          if (failure != null) ...[
            const SizedBox(height: CompetitionTokens.fieldGap),
            Text(failure, style: TextStyle(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: CompetitionTokens.sectionGap),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: enabled ? _submit : null,
              child: widget.isSubmitting
                  ? SizedBox.square(
                      dimension: CompetitionTokens.progressSize,
                      child: CircularProgressIndicator(
                        strokeWidth: CompetitionTokens.progressStroke,
                        color: theme.colorScheme.onSurface,
                      ),
                    )
                  : const Text(CompetitionStrings.grant),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateCompetitionName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return CompetitionStrings.fieldRequired;
    if (text.length > CompetitionInputRules.titleMaxLength) {
      return CompetitionStrings.tooLong(CompetitionInputRules.titleMaxLength);
    }
    return null;
  }

  String? _validateDiscordId(String? value) {
    final text = value?.trim() ?? '';
    if (!_discordId.hasMatch(text)) {
      return CompetitionStrings.winnerDiscordIdInvalid;
    }
    return null;
  }

  Future<void> _submit() async {
    if (widget.isSubmitting) return;
    final formValid = _formKey.currentState!.validate();
    final acquisition = _acquisition;
    setState(() {
      _dateError = acquisition == null
          ? CompetitionStrings.acquisitionRequired
          : null;
    });
    if (!formValid || acquisition == null) return;

    final draft = CompetitionWinnerDraft(
      competitionName: _competitionController.text.trim(),
      version: _version,
      winnerDiscordId: _discordIdController.text.trim(),
      acquisition: acquisition,
    );
    setState(() => _failureMessage = null);
    final failure = await widget.submit(draft);
    if (!mounted) return;
    if (failure == null) {
      _completeSuccess();
      return;
    }
    setState(() => _failureMessage = _failureText(failure));
  }

  /// 같은 대회로 여러 명에게 연달아 부여할 수 있도록 대회명과 날짜는 남기고 우승자만 비운다.
  void _completeSuccess() {
    _discordIdController.clear();
    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(const SnackBar(content: Text(CompetitionStrings.granted)));
  }

  String _failureText(CompetitionWinnerException failure) {
    return switch (failure.reason) {
      CompetitionWinnerFailure.invalid =>
        failure.message ?? CompetitionStrings.invalid,
      CompetitionWinnerFailure.notMember => CompetitionStrings.winnerNotMember,
      CompetitionWinnerFailure.conflict => CompetitionStrings.winnerConflict,
      CompetitionWinnerFailure.unknown => CompetitionStrings.grantUnknown,
    };
  }
}
