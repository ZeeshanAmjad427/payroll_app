import 'package:flutter/material.dart';

class TopLeftGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintTopLeft = Paint()
      ..shader = RadialGradient(
        colors: [const Color(0xff008B8B).withOpacity(0.3), Colors.white],
        radius: 0.9,
        center: Alignment.topLeft,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintTopLeft);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
