class ScreenWidth {
  static const double mobileWidth = 500.0;
  static const double tabletWidth = 900.0;
  static const double laptopWidth = 1350.0;

  static String widthChecker(double width) {
    if (width < mobileWidth) {
      return "mobileWidth";
    } else if (width < tabletWidth) {
      return "tabletWidth";
    } else if (width < laptopWidth) {
      return "laptopWidth";
    } else {
      return "wideWidth";
    }
  }
}
