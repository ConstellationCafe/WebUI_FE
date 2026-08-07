
import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/ConstPadding.dart';

class CustomPadding {
  CustomPadding({required this.child});

  Widget child;

  static Padding paddingAll01({required Widget child}) => Padding(padding: ConstPadding.bigPaddingAll, child: child);
  static Padding paddingAll02({required Widget child}) => Padding(padding: ConstPadding.middlePaddingAll, child: child);
  static Padding paddingAll03({required Widget child}) => Padding(padding: ConstPadding.smallPaddingAll, child: child);
  static Padding paddingAll04({required Widget child}) => Padding(padding: ConstPadding.tinyPaddingAll, child: child);

  static Padding paddingHorizontal01({required Widget child}) => Padding(padding: ConstPadding.bigPaddingHorizontal, child: child);
  static Padding paddingHorizontal02({required Widget child}) => Padding(padding: ConstPadding.middlePaddingHorizontal, child: child);
  static Padding paddingHorizontal03({required Widget child}) => Padding(padding: ConstPadding.smallPaddingHorizontal, child: child);
  static Padding paddingHorizontal04({required Widget child}) => Padding(padding: ConstPadding.tinyPaddingHorizontal, child: child);
}