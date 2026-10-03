import 'package:flutter/material.dart';

import '../../constants/date_time_picker_tokens.dart';

/// 날짜·시간 선택기 dialog의 색을 앱 theme에 맞춘다.
///
/// 앱 theme의 primary가 흰색이라 기본 선택기는 선택한 날짜, 시계 바늘, 선택한 시·분,
/// 확인·취소 버튼이 배경에 묻혀 보이지 않는다. 선택 상태는 진한 secondary 배경에
/// onSecondary 글자로, 나머지는 onSurface 글자로 칠한다.
/// 시간은 화면 표시(`HH:mm`)와 같은 24시간제로 고른다.
class AppPickerTheme extends StatelessWidget {
  final Widget child;

  const AppPickerTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final selected = scheme.secondary;
    final onSelected = scheme.onSecondary;
    final disabled = scheme.onSurface.withValues(
      alpha: DateTimePickerTokens.disabledOpacity,
    );

    Color foreground(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) return onSelected;
      if (states.contains(WidgetState.disabled)) return disabled;
      return scheme.onSurface;
    }

    Color background(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) return selected;
      return Colors.transparent;
    }

    final buttonStyle = TextButton.styleFrom(foregroundColor: selected);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: Theme(
        data: theme.copyWith(
          textButtonTheme: TextButtonThemeData(style: buttonStyle),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: scheme.surface,
            headerForegroundColor: scheme.onSurface,
            dayForegroundColor: WidgetStateProperty.resolveWith(foreground),
            dayBackgroundColor: WidgetStateProperty.resolveWith(background),
            todayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return onSelected;
              return selected;
            }),
            todayBackgroundColor: WidgetStateProperty.resolveWith(background),
            todayBorder: BorderSide(color: selected),
            yearForegroundColor: WidgetStateProperty.resolveWith(foreground),
            yearBackgroundColor: WidgetStateProperty.resolveWith(background),
            cancelButtonStyle: buttonStyle,
            confirmButtonStyle: buttonStyle,
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: scheme.surface,
            dialBackgroundColor: DateTimePickerTokens.dialBackground,
            dialHandColor: selected,
            dialTextColor: WidgetStateColor.resolveWith(foreground),
            hourMinuteColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return selected;
              return DateTimePickerTokens.dialBackground;
            }),
            hourMinuteTextColor: WidgetStateColor.resolveWith(foreground),
            dayPeriodColor: WidgetStateColor.resolveWith(background),
            dayPeriodTextColor: WidgetStateColor.resolveWith(foreground),
            entryModeIconColor: selected,
            cancelButtonStyle: buttonStyle,
            confirmButtonStyle: buttonStyle,
          ),
        ),
        child: child,
      ),
    );
  }
}
