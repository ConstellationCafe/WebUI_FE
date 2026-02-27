import 'package:flutter/cupertino.dart';

class ConstPadding {
  static const double bigPadding = 12.0;
  static const double mediumPadding = 8.0;
  static const double smallPadding = 6.0;
  static const double tinyPadding = 4.0;

  // 상하좌우
  static const EdgeInsetsGeometry bigPaddingAll = EdgeInsetsGeometry.all(bigPadding);
  static const EdgeInsetsGeometry middlePaddingAll = EdgeInsetsGeometry.all(mediumPadding);
  static const EdgeInsetsGeometry smallPaddingAll = EdgeInsetsGeometry.all(smallPadding);
  static const EdgeInsetsGeometry tinyPaddingAll = EdgeInsetsGeometry.all(tinyPadding);

  // 좌우
  static const EdgeInsetsGeometry bigPaddingHorizontal = EdgeInsetsGeometry.symmetric(horizontal: bigPadding);
  static const EdgeInsetsGeometry middlePaddingHorizontal = EdgeInsetsGeometry.symmetric(horizontal: mediumPadding);
  static const EdgeInsetsGeometry smallPaddingHorizontal = EdgeInsetsGeometry.symmetric(horizontal: smallPadding);
  static const EdgeInsetsGeometry tinyPaddingHorizontal = EdgeInsetsGeometry.symmetric(horizontal: tinyPadding);
}
