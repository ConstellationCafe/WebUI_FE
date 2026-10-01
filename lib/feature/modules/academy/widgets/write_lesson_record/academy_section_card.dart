import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class AcademySectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const AcademySectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: ConstPadding.smallPadding),
      child: Padding(
        padding: ConstPadding.mediumPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AcademyConstants.sectionIconBoxSize,
                  height: AcademyConstants.sectionIconBoxSize,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(
                      AcademyConstants.sectionIconBoxRadius,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: AcademyConstants.sectionIconSize,
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: ConstPadding.smallPadding),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: ConstPadding.mediumPadding),
            child,
          ],
        ),
      ),
    );
  }
}
