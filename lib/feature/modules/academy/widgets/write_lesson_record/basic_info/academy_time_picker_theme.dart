import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';

/// 수업 시간 선택 dialog의 버튼·오전/오후 선택 색상.
class AcademyTimePickerTheme extends StatelessWidget {
  final Widget child;

  const AcademyTimePickerTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Theme(
      data: theme.copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: colorScheme.secondary),
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: colorScheme.surface,
          dialBackgroundColor: AcademyConstants.timePickerDialBackground,
          dayPeriodColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.secondary;
            }
            return Colors.transparent;
          }),
          dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AcademyConstants.timePickerSelectedTextColor;
            }
            return AcademyConstants.timePickerUnselectedTextColor;
          }),
        ),
      ),
      child: child,
    );
  }
}
