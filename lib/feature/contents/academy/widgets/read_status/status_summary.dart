import 'package:constellation_cafe/feature/contents/academy/widgets/read_status/status_summary_item.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class StatusSummaryData {
  final String label;
  final int count;
  final IconData icon;

  const StatusSummaryData({
    required this.label,
    required this.count,
    required this.icon,
  });
}

class StatusSummary extends StatelessWidget {
  final String title;
  final List<StatusSummaryData> items;

  const StatusSummary({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.groups_outlined,
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.largePadding,
            ),
            Wrap(
              spacing:
              AcademyConstants.statusSummarySpacing,
              runSpacing:
              AcademyConstants.statusSummaryRunSpacing,
              children: items
                  .map(
                    (item) => StatusSummaryItem(
                  label: item.label,
                  count: item.count,
                  icon: item.icon,
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}