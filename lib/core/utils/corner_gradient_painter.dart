import 'package:flutter/material.dart';

class CornerGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintTopLeft = Paint()
      ..shader = RadialGradient(
        colors: [Color(0xff008B8B).withOpacity(0.4), Colors.transparent],
        radius: 1.0,
        center: Alignment.topLeft,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final Paint paintBottomRight = Paint()
      ..shader = RadialGradient(
        colors: [Color(0xffFF8000).withOpacity(0.4), Colors.transparent],
        radius: 1.0,
        center: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintTopLeft);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintBottomRight);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
