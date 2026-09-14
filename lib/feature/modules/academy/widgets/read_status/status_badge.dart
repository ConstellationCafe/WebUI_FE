import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';
import '../../domain/type/roster_status.dart';
import '../../domain/type/student_roster_status.dart';
import '../../domain/type/teacher_roster_status.dart';

class StatusBadge<T extends RosterStatus>
    extends StatelessWidget {
  final T status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (
    Color backgroundColor,
    Color foregroundColor,
    ) = _resolveColors(theme);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal:
        AcademyConstants.studentStatusBadgeHorizontalPadding,
        vertical:
        AcademyConstants.studentStatusBadgeVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AcademyConstants.studentStatusBadgeBorderRadius,
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

  (Color, Color) _resolveColors(ThemeData theme) {
    return switch (status) {
      StudentRosterStatus.enrolled ||
      TeacherRosterStatus.enrolled => (
      theme.colorScheme.primaryContainer,
      theme.colorScheme.onPrimaryContainer,
      ),

      StudentRosterStatus.graduation ||
      TeacherRosterStatus.retirement => (
      theme.colorScheme.secondaryContainer,
      theme.colorScheme.onSecondaryContainer,
      ),

      StudentRosterStatus.expulsion ||
      TeacherRosterStatus.disciplinary => (
      theme.colorScheme.errorContainer,
      theme.colorScheme.onErrorContainer,
      ),

      StudentRosterStatus.withdrawal => (
      theme.colorScheme.surfaceContainerHighest,
      theme.colorScheme.onSurfaceVariant,
      ),

      _ => (
      theme.colorScheme.surfaceContainerHighest,
      theme.colorScheme.onSurfaceVariant,
      ),
    };
  }
}