
class ConstSize {
  // Text Sizes - 현업 표준 typography scale
  static const double largeTextSize = 18.0;   // Headline
  static const double mediumTextSize = 16.0;  // Body Large
  static const double smallTextSize = 14.0;   // Body Medium
  static const double tinyTextSize = 12.0;    // Caption

  // Spacing - 8의 배수 기준 (Material Design 권장)
  static const double largeSpacing = 24.0;    // 3 * 8
  static const double mediumSpacing = 16.0;   // 2 * 8
  static const double smallSpacing = 8.0;     // 1 * 8
  static const double tinySpacing = 4.0;      // 0.5 * 8

  // Legacy support (기존 네이밍 유지)
  @Deprecated('Use largeSpacing instead')
  static const double bigWidth = largeSpacing;
  @Deprecated('Use mediumSpacing instead')
  static const double mediumWidth = mediumSpacing;
  @Deprecated('Use smallSpacing instead')
  static const double smallWidth = smallSpacing;
  @Deprecated('Use tinySpacing instead')
  static const double tinyWidth = tinySpacing;

  @Deprecated('Use largeSpacing instead')
  static const double bigHeight = largeSpacing;
  @Deprecated('Use mediumSpacing instead')
  static const double mediumHeight = mediumSpacing;
  @Deprecated('Use smallSpacing instead')
  static const double smallHeight = smallSpacing;
  @Deprecated('Use tinySpacing instead')
  static const double tinyHeight = tinySpacing;
}
