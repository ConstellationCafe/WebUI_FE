import 'package:flutter/material.dart';

class AuthConstants {
  static const String logoAsset = 'assets/icons/main_icon.jpg';

  // Login Card
  static const double loginCardMaxWidth = 360.0;
  static const double loginCardHorizontalPadding = 36.0;
  static const double loginCardVerticalPadding = 28.0;
  static const double loginCardRadius = 18.0;

  // Login Header
  static const double loginLogoSize = 52.0;
  static const double loginLogoRadius = 10.0;
  static const double loginTitleFontSize = 26.0;

  // Login Shadow
  static const Color loginShadowColor = Color(0x14000000);
  static const double loginShadowBlurRadius = 20.0;
  static const double loginShadowOffsetY = 6.0;

  // Discord Login Button
  static const double discordLoginButtonDesktopWidth = 160.0;
  static const double discordLoginButtonHeight = 40.0;
  static const double discordLoginButtonRadius = 5.0;
  static const double discordLoginButtonIconSize = 18.0;
  static const Color discordLoginButtonColor = Colors.blueAccent;
  static const Color discordLoginButtonTextColor = Colors.white;

  // 모바일(ScreenWidth.mobileWidth 미만): 화면 너비를 쓰고 요소를 키워 손가락으로 누르기
  // 쉽게 한다.
  static const double loginCardMobileMargin = 24.0;
  static const double loginCardMobileHorizontalPadding = 24.0;
  static const double loginCardMobileVerticalPadding = 32.0;
  static const double loginLogoMobileSize = 64.0;
  static const double loginTitleMobileFontSize = 28.0;
  static const double loginButtonMobileGap = 24.0;
  static const double discordLoginButtonMobileHeight = 52.0;
  static const double discordLoginButtonMobileIconSize = 22.0;
  static const double discordLoginButtonMobileFontSize = 18.0;
}
