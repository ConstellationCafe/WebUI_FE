import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';

import '../../constants/academy_constants.dart';
import 'status_summary_item.dart';

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

/// 현황 항목을 [width]에 둘 열 수를 정한다.
///
/// 항목이 [minItemWidth]보다 좁아지지 않는 가장 많은 열을 고르되, 마지막 줄만 덜 차는
/// 모양(예: 4개를 3열 + 1개)을 피하려고 항목 수의 약수가 되는 열 수로 줄인다.
/// 예: 4개 항목은 넓으면 4열, 좁으면 2열(2행 2열), 더 좁으면 1열.
int statusSummaryColumns({
  required double width,
  required int itemCount,
  required double minItemWidth,
  required double spacing,
}) {
  if (itemCount <= 1) return 1;
  final fit = ((width + spacing) / (minItemWidth + spacing)).floor();
  var columns = fit.clamp(1, itemCount);
  while (columns > 1 && itemCount % columns != 0) {
    columns--;
  }
  return columns;
}

class StatusSummary extends StatelessWidget {
  final String title;
  final List<StatusSummaryData> items;

  const StatusSummary({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compact = MediaQuery.sizeOf(context).width < ScreenWidth.mobileWidth;
    const spacing = AcademyConstants.statusSummarySpacing;

    return Card(
      child: Padding(
        padding: compact
            ? const EdgeInsets.all(AcademyConstants.statusCompactCardPadding)
            : ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.groups_outlined),
                const SizedBox(width: ConstPadding.smallPadding),
                Text(title, style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: ConstPadding.largePadding),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columns = statusSummaryColumns(
                  width: width,
                  itemCount: items.length,
                  minItemWidth: AcademyConstants.statusSummaryItemMinWidth,
                  spacing: spacing,
                );
                // 소수점 오차로 마지막 칸이 다음 줄로 밀리지 않게 내림한다.
                final gaps = spacing * (columns - 1);
                final itemWidth = ((width - gaps) / columns).floorToDouble();
                return Wrap(
                  spacing: spacing,
                  runSpacing: AcademyConstants.statusSummaryRunSpacing,
                  children: [
                    for (final item in items)
                      StatusSummaryItem(
                        width: itemWidth,
                        label: item.label,
                        count: item.count,
                        icon: item.icon,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
