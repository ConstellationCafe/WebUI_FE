import 'package:flutter/cupertino.dart';

class ConstPadding {
  // Padding Values - 8의 배수 기준 (Material Design 권장)
  static const double largePadding = 24.0;   // 3 * 8
  static const double mediumPadding = 16.0;  // 2 * 8  
  static const double smallPadding = 8.0;    // 1 * 8
  static const double tinyPadding = 4.0;     // 0.5 * 8

  // EdgeInsets - All directions
  static const EdgeInsets largePaddingAll = EdgeInsets.all(largePadding);
  static const EdgeInsets mediumPaddingAll = EdgeInsets.all(mediumPadding);
  static const EdgeInsets smallPaddingAll = EdgeInsets.all(smallPadding);
  static const EdgeInsets tinyPaddingAll = EdgeInsets.all(tinyPadding);

  // EdgeInsets - Horizontal only
  static const EdgeInsets largePaddingHorizontal = EdgeInsets.symmetric(horizontal: largePadding);
  static const EdgeInsets mediumPaddingHorizontal = EdgeInsets.symmetric(horizontal: mediumPadding);
  static const EdgeInsets smallPaddingHorizontal = EdgeInsets.symmetric(horizontal: smallPadding);
  static const EdgeInsets tinyPaddingHorizontal = EdgeInsets.symmetric(horizontal: tinyPadding);

  // EdgeInsets - Vertical only
  static const EdgeInsets largePaddingVertical = EdgeInsets.symmetric(vertical: largePadding);
  static const EdgeInsets mediumPaddingVertical = EdgeInsets.symmetric(vertical: mediumPadding);
  static const EdgeInsets smallPaddingVertical = EdgeInsets.symmetric(vertical: smallPadding);
  static const EdgeInsets tinyPaddingVertical = EdgeInsets.symmetric(vertical: tinyPadding);

  // Legacy support (기존 네이밍 유지)
  @Deprecated('Use largePadding instead')
  static const double bigPadding = largePadding;
  
  @Deprecated('Use largePaddingAll instead')
  static const EdgeInsetsGeometry bigPaddingAll = largePaddingAll;
  @Deprecated('Use mediumPaddingAll instead')  
  static const EdgeInsetsGeometry middlePaddingAll = mediumPaddingAll;
  
  @Deprecated('Use largePaddingHorizontal instead')
  static const EdgeInsetsGeometry bigPaddingHorizontal = largePaddingHorizontal;
  @Deprecated('Use mediumPaddingHorizontal instead')
  static const EdgeInsetsGeometry middlePaddingHorizontal = mediumPaddingHorizontal;
}
