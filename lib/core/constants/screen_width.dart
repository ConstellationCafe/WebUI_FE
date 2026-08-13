class ScreenWidth {
  static const String mobile = "mobileWidth";
  static const String tablet = "tabletWidth";
  static const String laptop = "laptopWidth";
  static const String wide = "wideWidth";

  static const double mobileWidth = 500.0;
  static const double tabletWidth = 900.0;
  static const double laptopWidth = 1350.0;

  static String widthChecker(double width) {
    if (width < mobileWidth) {
      return mobile;
    } else if (width < tabletWidth) {
      return tablet;
    } else if (width < laptopWidth) {
      return laptop;
    } else {
      return wide;
    }
  }

  static bool isDesktop(double width) {
    final deviceType = ScreenWidth.widthChecker(width);
    return deviceType == ScreenWidth.wide || deviceType == ScreenWidth.laptop;
  }
}
