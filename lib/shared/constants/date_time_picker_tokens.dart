import 'package:flutter/material.dart';

/// 공용 날짜·시간 입력란과 선택기 dialog token.
abstract final class DateTimePickerTokens {
  static const double segmentGap = 8.0;
  static const double segmentIconGap = 6.0;
  static const double segmentIconSize = 18.0;
  static const double segmentVerticalPadding = 4.0;
  static const double segmentRadius = 6.0;
  static const double disabledOpacity = 0.38;

  // 시간 선택 dialog(아카데미 수업 시간 선택기에서 옮겨 옴)
  static const Color timePickerSelectedTextColor = Color(0xFFFFFFFF);
  static const Color timePickerUnselectedTextColor = Color(0xFF000000);
  static const Color timePickerDialBackground = Color(0xFFEEEEEE);
}
