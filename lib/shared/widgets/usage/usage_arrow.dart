import 'package:flutter/material.dart';

import 'constants/usage_constants.dart';
import 'painter/arrow_painter.dart';

/// 안내 말풍선과 대상 사이의 화살표. [up]이면 위를 가리킨다.
class UsageArrow extends StatelessWidget {
  final bool up;

  const UsageArrow({super.key, required this.up});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: UsageConstants.arrowSize,
      painter: ArrowPainter(up: up),
    );
  }
}
