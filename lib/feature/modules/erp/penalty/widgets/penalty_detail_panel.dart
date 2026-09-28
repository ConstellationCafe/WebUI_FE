import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/calculate_penalty_cumulative.dart';
import '../domain/model/penalty_detail.dart';
import '../domain/model/penalty_log.dart';
import 'penalty_identity.dart';
import 'penalty_log_tile.dart';
import 'penalty_pager.dart';
import 'penalty_score_badge.dart';

class PenaltyDetailPanel extends StatelessWidget {
  final PenaltyDetail detail;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<PenaltyLog>? onCancel;
  final bool isSubmitting;
  final bool showSummaryScore;

  const PenaltyDetailPanel({
    super.key,
    required this.detail,
    required this.onPageChanged,
    this.onCancel,
    this.isSubmitting = false,
    this.showSummaryScore = true,
  });

  @override
  Widget build(BuildContext context) {
    final cumulativeScores = cumulativeScoresForLogs(
      logs: detail.history.items,
      newestFirst: true,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(PenaltyTokens.cardPadding),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PenaltyIdentity(
                      username: detail.username,
                      discordId: detail.discordId,
                      child: Text(
                        detail.username,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: PenaltyTokens.metadataTextSize / 2),
                    PenaltyIdentity(
                      username: detail.username,
                      discordId: detail.discordId,
                      child: Text(
                        '${detail.discordId} · ${detail.state}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: PenaltyTokens.metadataColor,
                          fontSize: PenaltyTokens.metadataTextSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showSummaryScore)
                PenaltyScoreBadge(
                  label: PenaltyStrings.currentScore,
                  score: detail.cumulativeScore30d,
                ),
            ],
          ),
          const SizedBox(height: PenaltyTokens.gap),
          Text(
            PenaltyStrings.history,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          if (detail.history.items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(PenaltyTokens.cardPadding),
              child: Text(PenaltyStrings.noHistory),
            ),
          for (var index = 0; index < detail.history.items.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: PenaltyTokens.cardGap),
              child: PenaltyLogTile(
                log: detail.history.items[index],
                cumulativeScore: cumulativeScores[index],
                onCancel:
                    onCancel == null ||
                        isSubmitting ||
                        detail.history.items[index].isCanceled
                    ? null
                    : () => onCancel!(detail.history.items[index]),
              ),
            ),
          PenaltyPager(
            page: detail.history.page,
            totalPages: detail.history.totalPages,
            disabled: isSubmitting,
            onChanged: onPageChanged,
          ),
        ],
      ),
    );
  }
}
