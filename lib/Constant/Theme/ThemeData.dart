import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: "Noto Sans KR",
    colorScheme: ColorScheme(
      brightness: Brightness.dark,

      // Primary colors
      primary: Color(0xFF000D27),
      onPrimary: Color(0xFFffffff),
      primaryContainer: Color(0xFF000D27),
      onPrimaryContainer: Color(0xFFffffff),

      // Secondary colors
      secondary: Color(0xFF000D27),
      onSecondary: Color(0xFFffffff),
      secondaryContainer: Color(0xFF000D27),
      onSecondaryContainer: Color(0xFFffffff),

      // Tertiary colors
      tertiary: Color(0xFF1A1A1E),
      onTertiary: Color(0xFFffffff),
      tertiaryContainer: Color(0xFF1A1A1E),
      onTertiaryContainer: Color(0xFFffffff),

      // Error colors
      error: Color(0xFF000D27),
      onError: Color(0xFFffffff),
      errorContainer: Color(0xFF1A1A1E),
      onErrorContainer: Color(0xFFffffff),

      // Surface colors
      surface: Color(0xFF1A1A1E),
      onSurface: Color(0xFFffffff),
      onSurfaceVariant: Color(0xFFffffff),

      // Outline colors
      outline: Color(0xFF000D27),
      outlineVariant: Color(0xFF1A1A1E),

      // Other colors
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFffffff),
      onInverseSurface: Color(0xFF1A1A1E),
      inversePrimary: Color(0xFF000D27),
    ),
  );
}