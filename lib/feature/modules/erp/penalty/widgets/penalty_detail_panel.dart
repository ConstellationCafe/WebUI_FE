import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';
import '../domain/model/penalty_detail.dart';
import '../domain/model/penalty_log.dart';
import 'penalty_log_tile.dart';
import 'penalty_pager.dart';

class PenaltyDetailPanel extends StatelessWidget {
  final PenaltyDetail detail;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<PenaltyLog>? onCancel;
  final bool isSubmitting;

  const PenaltyDetailPanel({
    super.key,
    required this.detail,
    required this.onPageChanged,
    this.onCancel,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(detail.username, style: Theme.of(context).textTheme.titleLarge),
        Text('${detail.discordId} · ${detail.state}'),
        const SizedBox(height: 16),
        Text(
          '${PenaltyStrings.currentScore}: ${detail.cumulativeScore30d}점',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          PenaltyStrings.history,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Divider(),
        if (detail.history.items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(PenaltyStrings.noHistory),
          ),
        for (final log in detail.history.items)
          PenaltyLogTile(
            log: log,
            onCancel: onCancel == null || isSubmitting || log.isCanceled
                ? null
                : () => onCancel!(log),
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
