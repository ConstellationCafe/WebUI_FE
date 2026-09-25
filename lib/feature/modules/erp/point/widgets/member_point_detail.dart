import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../domain/model/point_member_detail.dart';
import '../domain/model/point_log.dart';
import 'point_load_error.dart';

class MemberPointDetail extends StatelessWidget {
  final PointMemberDetail? detail;
  final bool isLoading;
  final bool isSubmitting;
  final bool hasError;
  final VoidCallback? onRetry;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<PointLog>? onEditLog;
  final ValueChanged<PointLog>? onDeleteLog;

  const MemberPointDetail({
    super.key,
    required this.detail,
    required this.isLoading,
    this.isSubmitting = false,
    this.hasError = false,
    this.onRetry,
    required this.onDeposit,
    required this.onWithdraw,
    required this.onPageChanged,
    this.onEditLog,
    this.onDeleteLog,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
    if (hasError) {
      return PointLoadError(
        message: PointStrings.detailFailed,
        onRetry: onRetry,
      );
    }
    final data = detail;
    if (data == null) {
      return const Center(child: Text(PointStrings.selectMember));
    }
    final number = NumberFormat.decimalPattern();
    final date = DateFormat('yyyy.MM.dd HH:mm');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              data.member.username,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('${data.member.discordId} · ${data.member.state}'),
            const SizedBox(height: 24),
            Text(
              PointStrings.balance,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              '${number.format(data.member.coin)} P',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: isSubmitting ? null : onDeposit,
                  icon: const Icon(Icons.add),
                  label: const Text(PointStrings.deposit),
                ),
                ElevatedButton.icon(
                  onPressed: isSubmitting ? null : onWithdraw,
                  icon: const Icon(Icons.remove),
                  label: const Text(PointStrings.withdraw),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              PointStrings.history,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            if (data.logs.isEmpty)
              const Center(child: Text(PointStrings.noHistory)),
            for (final log in data.logs) ...[
              Text(
                log.description.trim().isEmpty
                    ? PointStrings.noDescription
                    : log.description,
              ),
              Text(date.format(log.at.toLocal())),
              Text(
                '${log.amount > 0 ? '+' : ''}${number.format(log.amount)} P',
                style: TextStyle(
                  color: log.amount >= 0
                      ? PointTokens.positive
                      : PointTokens.negative,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: isSubmitting || onEditLog == null
                        ? null
                        : () => onEditLog!(log),
                    icon: const Icon(Icons.edit),
                    label: const Text(PointStrings.edit),
                  ),
                  ElevatedButton.icon(
                    onPressed: isSubmitting || onDeleteLog == null
                        ? null
                        : () => onDeleteLog!(log),
                    icon: const Icon(Icons.delete),
                    label: const Text(PointStrings.delete),
                  ),
                ],
              ),
              const Divider(),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: PointStrings.previousHistory,
                  onPressed: !isSubmitting && data.page > 1
                      ? () => onPageChanged(data.page - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '${data.page} / ${data.totalPages == 0 ? 1 : data.totalPages}',
                ),
                IconButton(
                  tooltip: PointStrings.nextHistory,
                  onPressed: !isSubmitting && data.page < data.totalPages
                      ? () => onPageChanged(data.page + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
