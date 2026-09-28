import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/penalty_strings.dart';
import '../domain/model/penalty_log.dart';

class PenaltyLogTile extends StatelessWidget {
  final PenaltyLog log;
  final VoidCallback? onCancel;

  const PenaltyLogTile({super.key, required this.log, this.onCancel});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('yyyy.MM.dd HH:mm');
    final channel = log.channelName?.trim().isNotEmpty == true
        ? log.channelName!
        : log.channelId;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Text(
                  '${log.targetUsername} · ${log.targetDiscordId}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Chip(
                  label: Text(
                    log.isCanceled
                        ? PenaltyStrings.canceled
                        : PenaltyStrings.active,
                  ),
                ),
                Text('${log.score}점'),
                Text(
                  '${PenaltyStrings.currentScore} ${log.targetCumulativeScore30d}점',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(log.reason),
            const SizedBox(height: 8),
            Text(
              '채널 $channel (${log.channelId}) · ${date.format(log.occurredAt.toLocal())}',
            ),
            Text('부여자 ${log.issuerDiscordId}'),
            if (log.isCanceled) ...[
              Text('취소 사유: ${log.cancellationReason ?? '-'}'),
              if (log.canceledAt != null)
                Text('취소 시각: ${date.format(log.canceledAt!.toLocal())}'),
            ],
            if (onCancel != null) ...[
              const SizedBox(height: 8),
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
