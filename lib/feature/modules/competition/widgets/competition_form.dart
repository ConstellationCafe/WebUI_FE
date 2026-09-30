import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../domain/competition_input_rules.dart';
import '../domain/model/competition_board.dart';
import '../domain/model/competition_draft.dart';
import '../domain/model/competition_failure.dart';
import '../domain/new_competition_request_id.dart';
import '../notifier/admin_competition_notifier.dart';
import 'competition_confirm_dialog.dart';
import 'competition_date_time_field.dart';
import 'competition_line_list.dart';

/// 대회 정보 입력 폼. 입력값과 컨트롤러는 이 위젯의 생명주기와 함께한다.
///
/// 입력이 멈추면 [onDraftChanged]로 미리보기를 요청한다. 요청 ID는 개최를 누를 때 한 번 만들고,
/// 결과를 알 수 없는 실패 뒤 다시 누르면 같은 ID를 재사용한다. 입력이 바뀌거나 게시에 성공하면 새로 만든다.
class CompetitionForm extends StatefulWidget {
  final List<CompetitionBoard> boards;
  final String? selectedBoardKey;
  final bool isLoadingBoards;
  final bool hasBoardsError;
  final bool isSubmitting;
  final ValueChanged<String?> onBoardChanged;
  final VoidCallback onRetryBoards;
  final ValueChanged<CompetitionDraft?> onDraftChanged;
  final Future<CompetitionPostOutcome> Function(
    String requestId,
    CompetitionDraft draft,
  )
  submit;

  /// 접수 마감 검증과 날짜 선택 기준 시각. 테스트에서 주입한다.
  final DateTime Function() clock;

  const CompetitionForm({
    super.key,
    required this.boards,
    required this.selectedBoardKey,
    required this.isLoadingBoards,
    required this.hasBoardsError,
    required this.isSubmitting,
    required this.onBoardChanged,
    required this.onRetryBoards,
    required this.onDraftChanged,
    required this.submit,
    this.clock = DateTime.now,
  });

  @override
  State<CompetitionForm> createState() => _CompetitionFormState();
}

class _CompetitionFormState extends State<CompetitionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _participantWayController = TextEditingController();
  final _formatController = TextEditingController();
  final List<CompetitionLine> _prizes = [];
  final List<CompetitionLine> _extraFields = [];
  DateTime? _registrationStart;
  DateTime? _registrationEnd;
  DateTime? _eventStart;
  String? _dateError;
  String? _requestId;
  String? _failureMessage;
  Timer? _previewTimer;

  List<TextEditingController> get _fixedControllers => [
    _titleController,
    _participantWayController,
    _formatController,
  ];

  @override
  void initState() {
    super.initState();
    for (final controller in _fixedControllers) {
      controller.addListener(_onInputChanged);
    }
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    for (final controller in _fixedControllers) {
      controller.dispose();
    }
    for (final line in [..._prizes, ..._extraFields]) {
      line.dispose();
    }
    super.dispose();
  }

  /// 입력이 바뀌면 이전 요청 ID를 버리고, 입력이 멈춘 뒤 미리보기를 다시 요청한다.
  void _onInputChanged() {
    _requestId = null;
    _previewTimer?.cancel();
    _previewTimer = Timer(CompetitionTokens.previewDebounce, () {
      if (mounted) widget.onDraftChanged(_draftOrNull());
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = !widget.isSubmitting;
    final failure = _failureMessage;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              CompetitionStrings.formSection,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          _boardField(enabled),
          const SizedBox(height: CompetitionTokens.fieldGap),
          TextFormField(
            controller: _titleController,
            enabled: enabled,
            maxLength: CompetitionInputRules.titleMaxLength,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.titleLabel,
            ),
            validator: _validateTitle,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          TextFormField(
            controller: _participantWayController,
            enabled: enabled,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.participantWayLabel,
              helperText: CompetitionStrings.participantWayHelper,
            ),
            validator: _validateRequiredLine,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          TextFormField(
            controller: _formatController,
            enabled: enabled,
            decoration: const InputDecoration(
              labelText: CompetitionStrings.formatLabel,
              helperText: CompetitionStrings.formatHelper,
            ),
            validator: _validateRequiredLine,
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          CompetitionDateTimeField(
            label: CompetitionStrings.registrationStartLabel,
            value: _registrationStart,
            enabled: enabled,
            clock: widget.clock,
            onChanged: (value) => _changeDate(() => _registrationStart = value),
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          CompetitionDateTimeField(
            label: CompetitionStrings.registrationEndLabel,
            value: _registrationEnd,
            enabled: enabled,
            clock: widget.clock,
            onChanged: (value) => _changeDate(() => _registrationEnd = value),
          ),
          const SizedBox(height: CompetitionTokens.fieldGap),
          CompetitionDateTimeField(
            label: CompetitionStrings.eventStartLabel,
            value: _eventStart,
            enabled: enabled,
            clock: widget.clock,
            errorText: _dateError,
            onChanged: (value) => _changeDate(() => _eventStart = value),
          ),
          const SizedBox(height: CompetitionTokens.rowGap),
          Text(
            CompetitionStrings.eventEndNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: CompetitionTokens.sectionGap),
          CompetitionLineList(
            title: CompetitionStrings.prizeSection,
            leftLabel: CompetitionStrings.prizeRankLabel,
            rightLabel: CompetitionStrings.prizeContentLabel,
            addLabel: CompetitionStrings.addPrize,
            lines: _prizes,
            maxLines: CompetitionInputRules.maxPrizes,
            enabled: enabled,
            onAdd: () => _addLine(_prizes),
            onRemove: (index) => _removeLine(_prizes, index),
            validateLeft: (_, value) => _validatePrizeRank(value),
            validateRight: (_, value) => _validateRequiredLine(value),
          ),
          const SizedBox(height: CompetitionTokens.sectionGap),
          CompetitionLineList(
            title: CompetitionStrings.extraSection,
            leftLabel: CompetitionStrings.extraKeyLabel,
            rightLabel: CompetitionStrings.extraValueLabel,
            addLabel: CompetitionStrings.addExtra,
            lines: _extraFields,
            maxLines: CompetitionInputRules.maxExtraFields,
            enabled: enabled,
            onAdd: () => _addLine(_extraFields),
            onRemove: (index) => _removeLine(_extraFields, index),
            validateLeft: _validateExtraKey,
            validateRight: (_, value) => _validateRequiredLine(value),
          ),
          if (failure != null) ...[
            const SizedBox(height: CompetitionTokens.fieldGap),
            Text(
              failure,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: CompetitionTokens.sectionGap),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: enabled && widget.selectedBoardKey != null
                  ? _submit
                  : null,
              child: widget.isSubmitting
                  ? SizedBox.square(
                      dimension: CompetitionTokens.progressSize,
                      child: CircularProgressIndicator(
                        strokeWidth: CompetitionTokens.progressStroke,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  : const Text(CompetitionStrings.submit),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boardField(bool enabled) {
    if (widget.isLoadingBoards) {
      return const Text(CompetitionStrings.boardsLoading);
    }
    if (widget.hasBoardsError) {
      return Row(
        children: [
          const Expanded(child: Text(CompetitionStrings.boardsFailed)),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: widget.onRetryBoards,
            child: const Text(CompetitionStrings.retry),
          ),
        ],
      );
    }
    if (widget.boards.isEmpty) {
      return const Text(CompetitionStrings.noBoards);
    }
    final selected = widget.boards
        .where((board) => board.key == widget.selectedBoardKey)
        .firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          initialValue: widget.selectedBoardKey,
          decoration: const InputDecoration(
            labelText: CompetitionStrings.boardLabel,
          ),
          items: [
            for (final board in widget.boards)
              DropdownMenuItem(value: board.key, child: Text(board.name)),
          ],
          onChanged: enabled ? _changeBoard : null,
          validator: (value) =>
              value == null ? CompetitionStrings.boardRequired : null,
        ),
        if (selected != null) ...[
          const SizedBox(height: CompetitionTokens.rowGap),
          Text(
            selected.joinable
                ? CompetitionStrings.joinableHint
                : CompetitionStrings.notJoinableHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  void _changeBoard(String? key) {
    _requestId = null;
    widget.onBoardChanged(key);
  }

  void _changeDate(VoidCallback update) {
    setState(() {
      update();
      _dateError = null;
    });
    _onInputChanged();
  }

  void _addLine(List<CompetitionLine> lines) {
    final line = CompetitionLine();
    line.left.addListener(_onInputChanged);
    line.right.addListener(_onInputChanged);
    setState(() => lines.add(line));
    _onInputChanged();
  }

  void _removeLine(List<CompetitionLine> lines, int index) {
    final line = lines[index];
    setState(() => lines.removeAt(index));
    _disposeAfterFrame([line]);
    _onInputChanged();
  }

  /// 입력란이 화면에서 빠진 다음 프레임에 컨트롤러를 해제한다.
  /// 바로 해제하면 아직 붙어 있는 입력란이 해제된 컨트롤러를 쓰게 된다.
  void _disposeAfterFrame(List<CompetitionLine> lines) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final line in lines) {
        line.dispose();
      }
    });
  }

  /// 필수 입력이 모두 있으면 미리보기·게시용 내용을, 아니면 null을 돌려준다.
  /// 세부 규칙 위반은 서버 미리보기가 안내한다.
  CompetitionDraft? _draftOrNull() {
    final start = _registrationStart;
    final end = _registrationEnd;
    final event = _eventStart;
    final title = _titleController.text.trim();
    final participantWay = _participantWayController.text.trim();
    final format = _formatController.text.trim();
    if (start == null || end == null || event == null) return null;
    if (title.isEmpty || participantWay.isEmpty || format.isEmpty) return null;
    return CompetitionDraft(
      title: title,
      participantWay: participantWay,
      format: format,
      registrationStart: start,
      registrationEnd: end,
      eventStart: event,
      prizes: [
        for (final line in _prizes)
          if (line.left.text.trim().isNotEmpty &&
              line.right.text.trim().isNotEmpty)
            CompetitionPrize(
              rank: line.left.text.trim(),
              content: line.right.text.trim(),
            ),
      ],
      extraFields: [
        for (final line in _extraFields)
          if (line.left.text.trim().isNotEmpty &&
              line.right.text.trim().isNotEmpty)
            CompetitionExtraField(
              key: line.left.text.trim(),
              value: line.right.text.trim(),
            ),
      ],
    );
  }

  String? _validateTitle(String? value) {
    final error = _validateRequiredLine(value);
    if (error != null) return error;
    final text = value!.trim();
    if (text.length > CompetitionInputRules.titleMaxLength) {
      return CompetitionStrings.tooLong(CompetitionInputRules.titleMaxLength);
    }
    if (text.contains('"')) return CompetitionStrings.titleQuote;
    return null;
  }

  String? _validateRequiredLine(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return CompetitionStrings.fieldRequired;
    if (!CompetitionInputRules.isSingleLine(text)) {
      return CompetitionStrings.singleLine;
    }
    if (text.length > CompetitionInputRules.valueMaxLength) {
      return CompetitionStrings.tooLong(CompetitionInputRules.valueMaxLength);
    }
    return null;
  }

  String? _validatePrizeRank(String? value) {
    final error = _validateRequiredLine(value);
    if (error != null) return error;
    final text = value!.trim();
    if (text.length > CompetitionInputRules.keyMaxLength) {
      return CompetitionStrings.tooLong(CompetitionInputRules.keyMaxLength);
    }
    if (text.contains(':')) return CompetitionStrings.keyColon;
    return null;
  }

  String? _validateExtraKey(int index, String? value) {
    final error = _validatePrizeRank(value);
    if (error != null) return error;
    final key = value!.trim();
    if (CompetitionInputRules.reservedKeys.contains(key)) {
      return CompetitionStrings.reservedKey;
    }
    final duplicated = _extraFields.indexed.any(
      (entry) => entry.$1 < index && entry.$2.left.text.trim() == key,
    );
    return duplicated ? CompetitionStrings.duplicateKey : null;
  }

  /// 날짜 입력 전체를 확인한다. 문제가 없으면 null
  String? _validateDates() {
    final start = _registrationStart;
    final end = _registrationEnd;
    final event = _eventStart;
    if (start == null || end == null || event == null) {
      return CompetitionStrings.dateRequired;
    }
    if (!start.isBefore(end)) return CompetitionStrings.registrationOrder;
    if (event.isBefore(end)) return CompetitionStrings.eventOrder;
    if (!end.isAfter(widget.clock())) return CompetitionStrings.deadlinePassed;
    return null;
  }

  Future<void> _submit() async {
    if (widget.isSubmitting) return;
    final formValid = _formKey.currentState!.validate();
    final dateError = _validateDates();
    setState(() => _dateError = dateError);
    if (!formValid || dateError != null) return;

    final draft = _draftOrNull();
    final board = widget.boards
        .where((board) => board.key == widget.selectedBoardKey)
        .firstOrNull;
    if (draft == null || board == null) return;

    final confirmed = await showCompetitionConfirmDialog(
      context,
      board: board,
      draft: draft,
    );
    if (!confirmed || !mounted) return;

    final requestId = _requestId ??= newCompetitionRequestId();
    setState(() => _failureMessage = null);
    final outcome = await widget.submit(requestId, draft);
    if (!mounted) return;
    final result = outcome.result;
    if (result != null) {
      _completeSuccess(result.messageUrl);
      return;
    }
    setState(() => _failureMessage = _failureText(outcome.failure));
  }

  void _completeSuccess(String? messageUrl) {
    _formKey.currentState?.reset();
    for (final controller in _fixedControllers) {
      controller.clear();
    }
    _disposeAfterFrame([..._prizes, ..._extraFields]);
    setState(() {
      _prizes.clear();
      _extraFields.clear();
      _registrationStart = null;
      _registrationEnd = null;
      _eventStart = null;
      _dateError = null;
    });
    // 입력란을 비우며 다시 걸린 미리보기 요청을 취소하고 미리보기를 직접 비운다.
    _previewTimer?.cancel();
    _requestId = null;
    widget.onDraftChanged(null);

    final url = messageUrl == null ? null : Uri.tryParse(messageUrl);
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: const Text(CompetitionStrings.posted),
        action: url == null
            ? null
            : SnackBarAction(
                label: CompetitionStrings.openDiscord,
                onPressed: () => launchUrl(url, webOnlyWindowName: '_blank'),
              ),
      ),
    );
  }

  String _failureText(CompetitionException? failure) {
    final message = failure?.message;
    return switch (failure?.reason) {
      CompetitionFailureReason.invalid => message ?? CompetitionStrings.invalid,
      CompetitionFailureReason.notConfigured =>
        message ?? CompetitionStrings.noBoards,
      CompetitionFailureReason.discord =>
        message ?? CompetitionStrings.discordFailed,
      CompetitionFailureReason.unknown ||
      null => CompetitionStrings.postUnknown,
    };
  }
}
