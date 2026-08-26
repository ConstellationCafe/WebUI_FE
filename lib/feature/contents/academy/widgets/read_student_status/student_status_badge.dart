import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';
import '../../domain/type/student_roster_status.dart';

class StudentStatusBadge extends StatelessWidget {
  final StudentRosterStatus status;

  const StudentStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color backgroundColor;
    final Color foregroundColor;

    switch (status) {
      case StudentRosterStatus.enrolled:
        backgroundColor =
            theme.colorScheme.primaryContainer;
        foregroundColor =
            theme.colorScheme.onPrimaryContainer;

      case StudentRosterStatus.graduation:
        backgroundColor =
            theme.colorScheme.secondaryContainer;
        foregroundColor =
            theme.colorScheme.onSecondaryContainer;

      case StudentRosterStatus.expulsion:
        backgroundColor =
            theme.colorScheme.errorContainer;
        foregroundColor =
            theme.colorScheme.onErrorContainer;

      case StudentRosterStatus.withdrawal:
        backgroundColor =
            theme.colorScheme.surfaceContainerHighest;
        foregroundColor =
            theme.colorScheme.onSurfaceVariant;

      case StudentRosterStatus.retirement:
        backgroundColor =
            theme.colorScheme.tertiaryContainer;
        foregroundColor =
            theme.colorScheme.onTertiaryContainer;

      case StudentRosterStatus.disciplinary:
        backgroundColor =
            theme.colorScheme.errorContainer;
        foregroundColor =
            theme.colorScheme.onErrorContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AcademyConstants
            .studentStatusBadgeHorizontalPadding,
        vertical: AcademyConstants
            .studentStatusBadgeVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AcademyConstants
              .studentStatusBadgeBorderRadius,
        ),
      ),
      child: Text(
        status.label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}