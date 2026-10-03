import 'package:flutter/material.dart';

import '../../constants/date_time_picker_tokens.dart';

/// 앱 공용 시간 선택기. 시간 입력이 필요한 화면은 `showTimePicker` 대신 이 함수를 쓴다.
Future<TimeOfDay?> showAppTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) => AppTimePickerTheme(child: child!),
  );
}

/// 시간 선택 dialog의 버튼·오전/오후 선택 색상.
///
/// 앱 theme의 primary가 흰색이라 기본 선택기는 확인·취소 버튼 글자와 선택한 오전/오후가
/// 보이지 않으므로 secondary 색으로 바꾼다.
class AppTimePickerTheme extends StatelessWidget {
  final Widget child;

  const AppTimePickerTheme({super.key, required this.child});

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
          dialBackgroundColor: DateTimePickerTokens.timePickerDialBackground,
          dayPeriodColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.secondary;
            }
            return Colors.transparent;
          }),
          dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return DateTimePickerTokens.timePickerSelectedTextColor;
            }
            return DateTimePickerTokens.timePickerUnselectedTextColor;
          }),
        ),
      ),
      child: child,
    );
  }
}
