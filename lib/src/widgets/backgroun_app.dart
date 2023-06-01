import 'package:flutter/material.dart';
import 'package:go_up/src/utils/colors.dart' as utils;

class BgApp extends StatelessWidget {
  bool? logo;
  String? text;
  BgApp({super.key,
    this.logo = false,
    this.text = ''
  });

  @override
  Widget build(BuildContext context) {
    if(logo == true){
      return _bgMainWithLogo(context);
    }
    if(text != ''){
      return _bgMainWithText(context, text!);
    }
    return _bgMain(context);
  }

  Widget _bgMain(BuildContext context){
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _PaintFigures(),
          )
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.35,
          top: MediaQuery.of(context).size.height * 0.758,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            child: const Icon(
              Icons.directions_bus,
              color: utils.Colors.colorAppBase,
              size:95,
            ),
          ),
        ),
      ]
    );
  }

  Widget _bgMainWithLogo(BuildContext context){
    return Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: _PaintFigures(),
              )
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/5.png',
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: utils.Colors.appColorNaranja
                  )
                ],
              )
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: MediaQuery.of(context).size.height * 0.758,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: const Icon(
                Icons.directions_bus,
                color: utils.Colors.colorAppBase,
                size:95,
              ),
            ),
          ),
        ]
    );
  }
  Widget _bgMainWithText(BuildContext context, String txt){
    return Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: _PaintFigures(),
              )
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      txt,
                      style: TextStyle(
                        fontSize: 42,
                        fontFamily: 'Balsamiq_Sans',
                        fontWeight: FontWeight.bold,
                        color: utils.Colors.appColorGris,
                      ),
                    )
                  ],
                )
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: MediaQuery.of(context).size.height * 0.758,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: const Icon(
                Icons.directions_bus,
                color: utils.Colors.colorAppBase,
                size:95,
              ),
            ),
          ),
        ]
    );
  }
}

class _PaintFigures extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // Header
    final lapiz = new Paint()
        ..color = utils.Colors.appColorAzul
        ..style = PaintingStyle.fill
        ..strokeWidth = 20;

    final path = new Path()
      ..lineTo(0, size.height * 0.35)
      ..lineTo(size.width,size.height * 0.35)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);

    //Futer
    final lapiz2 = new Paint()
      ..color = utils.Colors.colorAppBase
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path2 = new Path();

    path2.moveTo(0, size.height * 0.85);
    path2.lineTo(size.width * 0.35, size.height * 0.85);
    path2.moveTo(size.width * 0.65, size.height * 0.85);
    path2.lineTo(size.width, size.height * 0.85);
    canvas.drawPath(path2, lapiz2);
    var paint1 = Paint()
      ..color = utils.Colors.colorAppBase
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.85), size.width * 0.15, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw false;
  }
}