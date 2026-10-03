import 'package:flutter/material.dart';

/// 공용 날짜·시간 입력란과 선택기 dialog token.
abstract final class DateTimePickerTokens {
  /// 날짜 칸과 시간 칸 사이 간격
  static const double segmentGap = 8.0;

  /// 입력란 아래 안내·오류 문구 위치(입력란 안쪽 여백과 맞춤)
  static const double subtextTopGap = 4.0;
  static const double subtextHorizontalPadding = 16.0;

  static const double disabledOpacity = 0.38;

  // 시간 선택 dialog(아카데미 수업 시간 선택기에서 옮겨 옴)
  static const Color timePickerSelectedTextColor = Color(0xFFFFFFFF);
  static const Color timePickerUnselectedTextColor = Color(0xFF000000);
  static const Color timePickerDialBackground = Color(0xFFEEEEEE);
}
