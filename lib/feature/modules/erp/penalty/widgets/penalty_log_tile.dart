import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_log.dart';
import 'penalty_score_badge.dart';

class PenaltyLogTile extends StatelessWidget {
  final PenaltyLog log;
  final int? cumulativeScore;
  final VoidCallback? onCancel;

  const PenaltyLogTile({
    super.key,
    required this.log,
    this.cumulativeScore,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateFormat('yyyy.MM.dd HH:mm');
    final channel = log.channelName?.trim().isNotEmpty == true
        ? log.channelName!
        : log.channelId;
    final displayedCumulativeScore =
        cumulativeScore ?? log.targetCumulativeScore30d;
    final metadataStyle = theme.textTheme.bodySmall?.copyWith(
      color: PenaltyTokens.metadataColor,
      fontSize: PenaltyTokens.metadataTextSize,
    );
    final reasonStyle = theme.textTheme.titleMedium?.copyWith(
      fontSize: PenaltyTokens.reasonTextSize,
      fontWeight: FontWeight.w600,
    );
    final statusBackground = log.isCanceled
        ? PenaltyTokens.canceledStatusBackground
        : PenaltyTokens.activeStatusBackground;
    final statusForeground = log.isCanceled
        ? PenaltyTokens.canceledStatusForeground
        : PenaltyTokens.activeStatusForeground;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${log.targetUsername} · ${log.targetDiscordId}',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: PenaltyTokens.cardGap),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: PenaltyTokens.cardGap,
                        runSpacing: PenaltyTokens.cardGap,
                        children: [
                          Text(
                            '${PenaltyStrings.score} ${log.score}점',
                            style: theme.textTheme.titleSmall,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: statusBackground,
                              borderRadius: BorderRadius.circular(
                                PenaltyTokens.statusRadius,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    PenaltyTokens.statusHorizontalPadding,
                                vertical: PenaltyTokens.statusVerticalPadding,
                              ),
                              child: Text(
                                log.isCanceled
                                    ? PenaltyStrings.canceled
                                    : PenaltyStrings.active,
                                style: metadataStyle?.copyWith(
                                  color: statusForeground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: PenaltyTokens.gap),
                PenaltyScoreBadge(
                  score: displayedCumulativeScore,
                  compact: true,
                ),
              ],
            ),
            const SizedBox(height: PenaltyTokens.cardGap),
            Text(log.reason, style: reasonStyle),
            const SizedBox(height: PenaltyTokens.cardGap),
            Wrap(
              spacing: PenaltyTokens.gap,
              runSpacing: PenaltyTokens.metadataTextSize / 2,
              children: [
                Text(
                  '채널 $channel (${log.channelId})',
                  style: metadataStyle,
                ),
                Text(
                  '부여시간 ${date.format(log.occurredAt.toLocal())}',
                  style: metadataStyle,
                ),
                Text(
                  '부여자 ${log.issuerDiscordId}',
                  style: metadataStyle,
                ),
              ],
            ),
            if (log.isCanceled) ...[
              const SizedBox(height: PenaltyTokens.metadataTextSize / 2),
              Text(
                '취소 사유: ${log.cancellationReason ?? '-'}',
                style: metadataStyle,
              ),
              if (log.canceledAt != null)
                Text(
                  '취소 시각: ${date.format(log.canceledAt!.toLocal())}',
                  style: metadataStyle,
                ),
            ],
            if (onCancel != null) ...[
              const SizedBox(height: PenaltyTokens.cardGap),
              ElevatedButton.icon(
                onPressed: onCancel,
                icon: const Icon(Icons.undo),
                label: const Text(PenaltyStrings.cancelPenalty),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
