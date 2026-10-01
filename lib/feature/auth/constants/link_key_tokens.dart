/// 임시 연동 키 발급 화면(개발 중)의 크기·간격 token.
abstract final class LinkKeyTokens {
  static const Duration keyTtl = Duration(minutes: 1);
  static const Duration refreshInterval = Duration(milliseconds: 200);
  static const int codeLength = 6;

  static const double wideBreakpoint = 1100.0;
  static const double maxContentWidth = 1280.0;
  static const double pagePadding = 24.0;
  static const double columnGap = 24.0;
  static const double stackedGap = 16.0;
  static const int leftFlex = 8;
  static const int rightFlex = 4;

  static const double cardRadius = 16.0;
  static const double panelRadius = 14.0;
  static const double borderOpacity = 0.15;
  static const double sectionPadding = 24.0;
  static const double timerPanelPadding = 20.0;

  static const double topBarHorizontalPadding = 20.0;
  static const double topBarVerticalPadding = 14.0;
  static const double topBarLogoSize = 36.0;
  static const double topBarLogoRadius = 12.0;
  static const double topBarTitleSize = 20.0;
  static const double mutedTextOpacity = 0.7;
  static const double gap = 12.0;

  static const double titleSize = 28.0;
  static const double titleGap = 6.0;
  static const double stepsTopGap = 18.0;
  static const double keyLabelTopGap = 22.0;
  static const double keyLabelSize = 18.0;
  static const double keyLabelGap = 10.0;
  static const double buttonsTopGap = 14.0;
  static const double buttonHeight = 52.0;
  static const double noticeOpacity = 0.65;

  static const double codeBoxWidth = 520.0;
  static const double codeBoxHeight = 76.0;
  static const double codeBoxHorizontalPadding = 18.0;
  static const double codeBoxBorderWidth = 2.0;
  static const double codeTextSize = 28.0;
  static const double codeLetterSpacing = 2.0;

  static const double stepPadding = 14.0;
  static const double stepBackgroundOpacity = 0.55;
  static const double stepNumberSize = 32.0;
  static const double stepNumberRadius = 10.0;
  static const double stepInnerGap = 10.0;

  static const double timerTitleSize = 18.0;
  static const double timerSize = 160.0;
  static const double timerStrokeWidth = 12.0;
  static const double timerTextSize = 24.0;
  static const double sectionGap = 18.0;
  static const double qrPlaceholderOpacity = 0.6;
  static const double guidePadding = 16.0;
  static const double guideBackgroundOpacity = 0.6;
}
