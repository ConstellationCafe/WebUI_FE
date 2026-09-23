import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../domain/model/point_member_detail.dart';

class MemberPointDetail extends StatelessWidget {
  final PointMemberDetail? detail;
  final bool isLoading;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  final ValueChanged<int> onPageChanged;

  const MemberPointDetail({
    super.key,
    required this.detail,
    required this.isLoading,
    required this.onDeposit,
    required this.onWithdraw,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    final data = detail;
    if (data == null) {
      return const Center(child: Text(PointStrings.selectMember));
    }
    final number = NumberFormat.decimalPattern();
    final date = DateFormat('yyyy.MM.dd HH:mm');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                FilledButton.icon(
                  onPressed: onDeposit,
                  icon: const Icon(Icons.add),
                  label: const Text(PointStrings.deposit),
                ),
                OutlinedButton.icon(
                  onPressed: onWithdraw,
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
            Expanded(
              child: data.logs.isEmpty
                  ? const Center(child: Text(PointStrings.noHistory))
                  : ListView.separated(
                      itemCount: data.logs.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final log = data.logs[index];
                        final color = log.amount >= 0
                            ? PointTokens.positive
                            : PointTokens.negative;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(log.description),
                          subtitle: Text(date.format(log.at.toLocal())),
                          trailing: Text(
                            '${log.amount > 0 ? '+' : ''}${number.format(log.amount)} P',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: '이전 내역',
                  onPressed: data.page > 1
                      ? () => onPageChanged(data.page - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text('${data.page} / ${data.totalPages == 0 ? 1 : data.totalPages}'),
                IconButton(
                  tooltip: '다음 내역',
                  onPressed: data.page < data.totalPages
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
