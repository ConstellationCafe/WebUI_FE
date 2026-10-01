import 'package:flutter/material.dart';

class UsageConstants {
  static const double contentGap = 40.0;
  static const double contentHeight = 120.0;

  static const double minContentWidth = 200.0;
  static const double maxContentWidth = 400.0;

  static const double screenHorizontalPadding = 8.0;

  static const int scrollDurationMilliseconds = 300;

  static const Color contentBackgroundColor = Color(0xFF1E2433);
  static const double contentBackgroundOpacity = 0.95;
  static const double contentBorderRadius = 12.0;

  static const Color contentPanelColor = Color.from(
    alpha: 0.8,
    red: 0,
    green: 0,
    blue: 0,
  );
  static const Color contentForeground = Color(0xFFFFFFFF);
  static const double previousButtonBackgroundOpacity = 0.15;
  static const double previousButtonBorderOpacity = 0.3;
  static const double nextButtonBackgroundOpacity = 0.25;
  static const double navigationButtonRadius = 20.0;

  static const Size arrowSize = Size(20, 10);
  static const Color scrimColor = Color.from(
    alpha: 0.7,
    red: 0,
    green: 0,
    blue: 0,
  );
  static const double holeInflate = 8.0;
  static const double holeRadius = 12.0;
  static const Duration overlayAnimationDuration = Duration(milliseconds: 250);
  static const double overlaySlideOffset = 0.1;
}
