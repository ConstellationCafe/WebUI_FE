import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';

/// 홈 빠른 이동 카드.
class HomeActionCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const HomeActionCard({
    super.key,
    required this.width,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Material(
        color: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HomeConstants.cardRadius),
          side: const BorderSide(color: HomeConstants.actionBorderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(HomeConstants.cardRadius),
          child: Padding(
            padding: const EdgeInsets.all(ConstPadding.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: HomeConstants.actionIconSize,
                  color: HomeConstants.heroForeground,
                ),
                const SizedBox(height: ConstSize.mediumSpacing),
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: ConstSize.tinySpacing),
                Text(description, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
