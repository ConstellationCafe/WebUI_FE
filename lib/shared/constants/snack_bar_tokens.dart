import 'package:flutter/material.dart';

/// 공용 결과 SnackBar의 크기·간격 token.
abstract final class SnackBarTokens {
  static const double margin = 16.0;
  static const double elevation = 8.0;
  static const double radius = 14.0;
  static const double iconGap = 12.0;
  static const double progressSize = 18.0;
  static const double progressStrokeWidth = 2.4;
  static const Duration defaultDuration = Duration(seconds: 3);

  /// 진행 중 SnackBar는 작업이 끝나 직접 닫을 때까지 유지한다.
  static const Duration loadingDuration = Duration(days: 1);

  // 전역 오류 SnackBar
  static const Color errorBackground = Color(0xFFE53935);
  static const Color errorForeground = Color(0xFFFFFFFF);
  static const double errorIconSize = 20.0;
  static const double errorIconGap = 8.0;
  static const double errorTextSize = 14.0;
  static const double errorRadius = 8.0;
  static const Duration errorDuration = Duration(seconds: 4);
}
