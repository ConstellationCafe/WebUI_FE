import 'package:flutter/material.dart';

abstract final class FriendlyMatchConstants {
  static const double contentWidth = 400.0;

  // Card
  static const double cardRadius = 10.0;
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadowColor = Color.from(
    alpha: 0.12,
    red: 0,
    green: 13 / 255,
    blue: 39 / 255,
  );
  static const double cardShadowBlur = 24.0;
  static const Offset cardShadowOffset = Offset(0, 8);

  // Input
  static const double fieldHeight = 40.0;
  static const int messageLines = 3;
  static const Color cursorColor = Color(0xFF000000);

  // Preview
  static const double cafeIconSize = 40.0;
  static const double cafeIconRadius = 6.0;
  static const String cafeIcon = 'assets/icons/main_icon.jpg';
  static const int howToRecruitMaxLines = 2;

  // Submit
  static const Color submitBackground = Color(0xFF444444);
  static const Color submitForeground = Color(0xFFFFFFFF);
  static const double submitVerticalPadding = 12.0;
  static const double submitRadius = 6.0;
  static const double submitProgressSize = 16.0;
  static const double submitProgressStrokeWidth = 2.0;

  static const BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
    boxShadow: [
      BoxShadow(
        color: cardShadowColor,
        blurRadius: cardShadowBlur,
        offset: cardShadowOffset,
      ),
    ],
  );
}
