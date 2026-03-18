import 'package:flutter/material.dart';

class CustomTheme {
  // 색상 상수 정의
  static const Color primaryColor = Color(0xFFffffff);
  static const Color secondaryColor = Color(0xFF000D27);
  static const Color tertiaryColor = Color(0xFF1A1A1E);
  static const Color surfaceColor = Color(0xFFF5F6F7);
  static const Color errorColor = Color(0xFFD32F2F);

  static ThemeData themeData = ThemeData(
    fontFamily: "Noto Sans KR",
    
    // 색상 체계
    colorScheme: ColorScheme(
      brightness: Brightness.light,

      // Primary colors
      primary: primaryColor,
      onPrimary: secondaryColor,
      primaryContainer: primaryColor,
      onPrimaryContainer: secondaryColor,

      // Secondary colors
      secondary: secondaryColor,
      onSecondary: primaryColor,
      secondaryContainer: secondaryColor,
      onSecondaryContainer: primaryColor,

      // Tertiary colors
      tertiary: tertiaryColor,
      onTertiary: primaryColor,
      tertiaryContainer: tertiaryColor,
      onTertiaryContainer: tertiaryColor,

      // Error colors
      error: errorColor,
      onError: primaryColor,
      errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: errorColor,

      // Surface colors
      surface: surfaceColor,
      onSurface: tertiaryColor,
      onSurfaceVariant: tertiaryColor,

      // Outline colors
      outline: secondaryColor,
      outlineVariant: tertiaryColor,

      // Other colors
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: primaryColor,
      onInverseSurface: tertiaryColor,
      inversePrimary: secondaryColor,
    ),

    // Typography 체계 강화
    textTheme: TextTheme(
      // Headlines
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
      ),
      
      // Titles
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      
      // Body text
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: tertiaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: tertiaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: tertiaryColor,
      ),
      
      // Labels
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
    ),

    // 입력 위젯 테마
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFE0E0E0), // 더 명확한 배경색
      labelStyle: TextStyle(color: secondaryColor),
      hintStyle: TextStyle(color: Colors.grey[600]),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // 8의 배수
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: secondaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: errorColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // 드롭다운 테마
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: tertiaryColor),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: secondaryColor),
        filled: true,
        fillColor: Color(0xFFE0E0E0),
      ),
    ),

    // 버튼 테마
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 8의 배수
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // 8의 배수
        elevation: 2,
      ),
    ),

    // Card 테마
    cardTheme: CardThemeData(
      color: primaryColor,
      shadowColor: Colors.black26,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(8),
    ),

    // AppBar 테마
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      elevation: 1,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
        fontFamily: "Noto Sans KR",
      ),
    ),
  );
}
