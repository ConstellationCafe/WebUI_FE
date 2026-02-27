import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: "Noto Sans KR",
    // Material 컴포넌트의 기본 색상
    colorScheme: ColorScheme(
      brightness: Brightness.light,

      /**
      How to Use
      primary : 컴포넌트 색상 (메인)
      primaryContainer : 컴포넌트 색상 (서브)
      onPrimary : primary 위에 올려지는 텍스트나 아이콘 색상
      onPrimaryContainer : primaryContainer 위에 올려지는 텍스트나 아이콘 색상
      */

      // Primary colors
      primary: Color(0xFFffffff),
      onPrimary: Color(0xFF000D27),
      primaryContainer: Color(0xFFffffff),
      onPrimaryContainer: Color(0xFF000D27),

      // Secondary colors
      secondary: Color(0xFF000D27),
      onSecondary: Color(0xFFffffff),
      secondaryContainer: Color(0xFF000D27),
      onSecondaryContainer: Color(0xFFffffff),

      // Tertiary colors
      tertiary: Color(0xFF1A1A1E),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF1A1A1E),
      onTertiaryContainer: Color(0xFF1A1A1E),

      // Error colors
      error: Color(0xFF000D27),
      onError: Color(0xFFffffff),
      errorContainer: Color(0xFF1A1A1E),
      onErrorContainer: Color(0xFFffffff),

      // Surface colors
      surface: Color(0xFFF5F6F7),
      onSurface: Color(0xFF1A1A1E),
      onSurfaceVariant: Color(0xFF1A1A1E),

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

    // 입력 위젯 전용 스타일
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[350],
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF555555)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF888888)),
      ),
    ),

    // 드롭다운 전용 스타일
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.black),   // 메뉴 아이템 텍스트 색상
      inputDecorationTheme: InputDecorationTheme(  // 입력창 관련
        labelStyle: TextStyle(color: Colors.black),
      ),
    ),

    // ElevatedButton 색상 지정
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // 버튼 배경색
        foregroundColor: Color(0xFFFFFFFF), // 글자색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // 버튼 모서리 둥글기
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // 버튼 패딩
      ),
    ),
  );
}
