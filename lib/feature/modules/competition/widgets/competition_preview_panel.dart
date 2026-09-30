import 'package:flutter/material.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../domain/model/competition_failure.dart';

/// 서버가 조립한 실제 게시글과 봇 인식 가능 여부를 보여준다.
class CompetitionPreviewPanel extends StatelessWidget {
  final String? preview;
  final CompetitionException? failure;
  final bool isPreviewing;

  const CompetitionPreviewPanel({
    super.key,
    required this.preview,
    required this.failure,
    required this.isPreviewing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = preview;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            CompetitionStrings.previewSection,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: CompetitionTokens.rowGap),
        Container(
          constraints: const BoxConstraints(
            minHeight: CompetitionTokens.previewMinHeight,
          ),
          padding: const EdgeInsets.all(CompetitionTokens.previewPadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(
              CompetitionTokens.previewRadius,
            ),
            border: Border.all(color: theme.dividerColor),
          ),
          child: content == null
              ? Text(
                  CompetitionStrings.previewEmpty,
                  style: theme.textTheme.bodyMedium,
                )
              : SelectableText(content, style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(height: CompetitionTokens.rowGap),
        _status(theme),
      ],
    );
  }

  Widget _status(ThemeData theme) {
    if (isPreviewing) {
      return Row(
        children: [
          SizedBox.square(
            dimension: CompetitionTokens.progressSize,
            child: CircularProgressIndicator(
              strokeWidth: CompetitionTokens.progressStroke,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: CompetitionTokens.rowGap),
          const Flexible(child: Text(CompetitionStrings.previewLoading)),
        ],
      );
    }
    final error = failure;
    if (error != null) {
      final message = error.reason == CompetitionFailureReason.invalid
          ? (error.message ?? CompetitionStrings.previewFailed)
          : CompetitionStrings.previewFailed;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error),
          const SizedBox(width: CompetitionTokens.rowGap),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      );
    }
    if (preview != null) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline),
          SizedBox(width: CompetitionTokens.rowGap),
          Expanded(child: Text(CompetitionStrings.previewValid)),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
