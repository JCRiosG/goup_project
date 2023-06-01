import 'package:flutter/material.dart';
import 'package:go_up/src/utils/colors.dart' as utils;

class PaintFigures extends CustomPainter{

  Color? color;
  String? style;
  double? swidth;
  Path? path;

  PaintFigures({
    this.color = Colors.white,
    this.style = 'stroke',
    this.swidth = 5,
    required this.path,
    //required this.onPressed,

  });

  @override
  void paint(Canvas canvas, Size size) {
    // properties
    final lapiz = Paint();
     lapiz.color = color!;
     lapiz.style = PaintingStyle.stroke;
     if(style == 'fill') {
       lapiz.style = PaintingStyle.fill;
     }
     lapiz.strokeWidth = swidth!;
     final pathFigure = path;

    canvas.drawPath(pathFigure!, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
  
}