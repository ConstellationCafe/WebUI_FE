import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/utils/date_formatter.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../domain/model/competition_winner.dart';

/// 현재 채팅방의 우승 칭호 부여 이력과 페이지 이동.
class CompetitionWinnerHistory extends StatelessWidget {
  final List<CompetitionWinner> items;
  final bool isLoading;
  final bool hasError;
  final int page;
  final int totalPages;
  final VoidCallback onRetry;
  final ValueChanged<int> onPageChanged;

  const CompetitionWinnerHistory({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasError,
    required this.page,
    required this.totalPages,
    required this.onRetry,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            CompetitionStrings.winnerHistory,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: CompetitionTokens.rowGap),
        _body(theme),
        if (!isLoading && !hasError && totalPages > 1) _pager(),
      ],
    );
  }

  Widget _body(ThemeData theme) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(CompetitionTokens.fieldGap),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (hasError) {
      return Row(
        children: [
          const Expanded(child: Text(CompetitionStrings.winnerHistoryFailed)),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.secondary,
            ),
            onPressed: onRetry,
            child: const Text(CompetitionStrings.retry),
          ),
        ],
      );
    }
    if (items.isEmpty) {
      return const Text(CompetitionStrings.noWinnerHistory);
    }
    // 이력 한 건을 흰 배경 카드로 구분한다(알림 발행 이력 카드와 같은 Card theme).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final winner in items) ...[
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: CompetitionTokens.winnerCardPadding,
              ),
              leading: const Icon(Icons.emoji_events_outlined),
              title: Text(winner.competitionName),
              subtitle: Text(
                CompetitionStrings.winnerSubtitle(
                  name: winner.winnerName ?? CompetitionStrings.unknownMember,
                  discordId: winner.winnerDiscordId,
                  version: winner.version.typeToString(),
                  date: DateFormatter.toYyyyMmDd(winner.acquisition),
                ),
              ),
              isThreeLine: true,
            ),
          ),
          const SizedBox(height: CompetitionTokens.rowGap),
        ],
      ],
    );
  }

  Widget _pager() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: CompetitionStrings.previousPage,
          onPressed: page > 1 ? () => onPageChanged(page - 1) : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(CompetitionStrings.pageIndicator(page, totalPages)),
        IconButton(
          tooltip: CompetitionStrings.nextPage,
          onPressed: page < totalPages ? () => onPageChanged(page + 1) : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
