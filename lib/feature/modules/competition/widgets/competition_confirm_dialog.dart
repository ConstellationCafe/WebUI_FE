import 'package:flutter/material.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../domain/model/competition_board.dart';
import '../domain/model/competition_draft.dart';

/// 게시 전에 게시판, 대회명, 일정과 봇이 자동으로 하는 일을 확인받는다.
/// 게시를 누르면 true, 취소하거나 닫으면 false를 돌려준다.
Future<bool> showCompetitionConfirmDialog(
  BuildContext context, {
  required CompetitionBoard board,
  required CompetitionDraft draft,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => _CompetitionConfirmDialog(board: board, draft: draft),
  );
  return confirmed ?? false;
}

class _CompetitionConfirmDialog extends StatelessWidget {
  final CompetitionBoard board;
  final CompetitionDraft draft;

  const _CompetitionConfirmDialog({required this.board, required this.draft});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text(CompetitionStrings.confirmTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: CompetitionTokens.dialogMaxWidth,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row(theme, CompetitionStrings.confirmBoard, board.name),
              _row(theme, CompetitionStrings.confirmName, draft.title.trim()),
              _row(
                theme,
                CompetitionStrings.confirmDeadline,
                CompetitionStrings.formatDateTime(draft.registrationEnd),
              ),
              _row(
                theme,
                CompetitionStrings.confirmStart,
                CompetitionStrings.formatDateTime(draft.eventStart),
              ),
              const SizedBox(height: CompetitionTokens.fieldGap),
              Text(
                board.joinable
                    ? CompetitionStrings.confirmJoinable
                    : CompetitionStrings.confirmNotJoinable,
              ),
              const SizedBox(height: CompetitionTokens.rowGap),
              Text(
                CompetitionStrings.confirmNoEdit,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      actions: [
        // 다른 관리자 다이얼로그처럼 취소도 ElevatedButton을 쓴다(흰색 TextButton은 보이지 않음).
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(CompetitionStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(CompetitionStrings.submit),
        ),
      ],
    );
  }

  Widget _row(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CompetitionTokens.rowGap),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: CompetitionTokens.confirmLabelWidth,
            child: Text(label, style: theme.textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
