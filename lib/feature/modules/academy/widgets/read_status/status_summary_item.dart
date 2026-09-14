import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class StatusSummaryItem extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;

  const StatusSummaryItem({
    super.key,
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: AcademyConstants.statusSummaryItemWidth,
      padding: ConstPadding.mediumPaddingAll,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          AcademyConstants.cardBorderRadius,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(
            width: ConstPadding.mediumPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '$count명',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}