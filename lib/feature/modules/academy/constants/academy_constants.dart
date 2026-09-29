import 'package:flutter/material.dart';

abstract final class AcademyConstants {
  // Layout
  static const double contentMaxWidth = 1100;

  // Breadcrumb
  static const double breadcrumbIconHorizontalPadding = 8;
  static const double breadcrumbIconSize = 16;

  // Saving indicator
  static const double savingIndicatorSize = 16;
  static const double savingIndicatorStrokeWidth = 2;

  // Write Lesson Record
  static const double memberChipSpacing = 8;
  static const double memberChipRunSpacing = 8;
  static const double memberAvatarRadius = 12;

  // Read Lesson Record
  static const double cardBorderRadius = 12.0;
  static const double filterFieldWidth = 220.0;
  static const double recordCardSpacing = 12.0;
  static const double memberIconSize = 16.0;
  static const double emptyIconSize = 48.0;

  // Read Student Status - Filter
  static const double statusFilterFieldWidth = 240.0;
  static const double statusFilterSpacing = 16.0;
  static const double statusFilterRunSpacing = 16.0;

  // Read Student Status - Summary
  static const double statusSummaryItemWidth = 180.0;
  static const double statusSummarySpacing = 12.0;
  static const double statusSummaryRunSpacing = 12.0;

  // Read Student Status - Table
  static const double statusTableMinWidth = 900.0;
  static const double statusTableColumnSpacing = 32.0;
  static const double statusTableHeaderHeight = 48.0;
  static const double statusTableRowHeight = 56.0;

  // Read Student Status - Badge
  static const double studentStatusBadgeHorizontalPadding = 12.0;
  static const double studentStatusBadgeVerticalPadding = 6.0;
  static const double studentStatusBadgeBorderRadius = 16.0;

  // Read Student Status - Pagination
  static const double statusPaginationButtonSize = 40.0;
  static const double statusPaginationSpacing = 4.0;

  // Time Picker
  static const Color timePickerSelectedTextColor = Color(0xFFFFFFFF);
  static const Color timePickerUnselectedTextColor = Color(0xFF000000);
  static const Color timePickerDialBackground = Color(0xFFEEEEEE);

  // Form
  static const double fieldLabelGap = 6.0;
  static const Color requiredMarkColor = Color(0xFFF44336);
  static const double timeRangeSeparatorPadding = 8.0;
  static const TimeOfDay defaultLessonStartTime = TimeOfDay(
    hour: 10,
    minute: 0,
  );
  static const TimeOfDay defaultLessonEndTime = TimeOfDay(hour: 12, minute: 0);
  static final DateTime firstSelectableDate = DateTime(2020);
  static final DateTime firstEditableDate = DateTime(2000);
  static final DateTime lastSelectableDate = DateTime(2100);
  static const int lessonDescriptionLines = 7;
  static const int lessonDescriptionMaxLength = 1000;
  static const int statusReasonLines = 4;

  // Write Lesson Record - Section card
  static const double sectionIconBoxSize = 32.0;
  static const double sectionIconBoxRadius = 8.0;
  static const double sectionIconSize = 18.0;

  // Read Lesson Record - Edit dialog & filter
  static const double editDialogFieldGap = 12.0;
  static const int editDescriptionMinLines = 3;
  static const int editDescriptionMaxLines = 6;
  static const int morningFilterHour = 9;
  static const int afternoonFilterHour = 14;
}
