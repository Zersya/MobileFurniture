import 'package:flutter/material.dart';

class backgroundPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // set the paint color to be white
    paint.color = Color.fromRGBO(223, 211, 195, 1);

    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(backgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(backgroundPainter oldDelegate) => false;
}