import 'package:flutter/material.dart';

class HolePainter extends CustomPainter {
  final Rect rect;

  HolePainter({required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7);

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    final layer = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.saveLayer(layer, Paint());

    // 전체 덮기
    canvas.drawRect(layer, backgroundPaint);

    // 구멍 뚫기 (라운드 처리)
    final centerX = size.width / 2 - rect.width / 2;
    final centerY = size.height / 2 - rect.height / 2;

    final adjustedRect = Rect.fromLTWH(centerX, centerY, rect.width, rect.height);

    final rrect = RRect.fromRectAndRadius(adjustedRect.inflate(8), Radius.circular(12));
    canvas.drawRRect(rrect, clearPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}