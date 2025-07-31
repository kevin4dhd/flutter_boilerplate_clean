import 'package:flutter/material.dart';

import '../../../app.dart';

class SplashDecorativePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.current.terciaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;

    final points = <Offset>[
      Offset(width * -0.65, height * 0.8),
      Offset(width * 0.3, height * 0.65),
      Offset(width * 1.1, height * 0.48),
      Offset(width * 1.1, height * 0.7),
      Offset(width * 0.5, height * 0.8),
      Offset(width * 0, height * 0.9),
      Offset(width * 0.5, height * 1),
    ];
    final length = points.length;

    final path = Path();
    path.moveTo(width, height * 0.35);

    for (int i = 0; i < length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final controlPoint = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );

      path.quadraticBezierTo(p1.dx, p1.dy, controlPoint.dx, controlPoint.dy);
    }

    path.lineTo(points.last.dx, points.last.dy);

    createDashedPath(canvas, path, paint);
  }

  void createDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 4.0;
    final totalLength = path.computeMetrics().first.length;
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < totalLength) {
        final nextDistance = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, nextDistance), paint);
        distance = nextDistance + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
