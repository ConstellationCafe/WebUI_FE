import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';

class StatusSummaryItem extends StatelessWidget {
  final double width;
  final String label;
  final int count;
  final IconData icon;

  const StatusSummaryItem({
    super.key,
    required this.width,
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      padding: ConstPadding.mediumPaddingAll,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AcademyConstants.cardBorderRadius),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.secondary),
          const SizedBox(width: ConstPadding.smallPadding),
          // 2열처럼 좁은 칸에서도 넘치지 않도록 남은 너비 안에서 말줄임 처리한다.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: ConstPadding.tinyPadding),
                Text(
                  AcademyStrings.peopleCount(count),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
