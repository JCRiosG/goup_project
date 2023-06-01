import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_up/src/utils/colors.dart' as utils;

class BannerApp extends StatelessWidget {
  //const ButtonApp({Key? key}) : super(key: key);

  Color? bgColor;
  String? text;
  Color? txtColor;
  String? uriLogo;

  //Function onPressed;

  BannerApp({super.key,
    this.bgColor = Colors.white,
    this.text = 'Bienvenido',
    this.txtColor = utils.Colors.colorAppBase,
    this.uriLogo = 'assets/images/5.png',
    //required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    if(text != '') {
      return _bannerMain(context);
    } else {
      return _bannerWithText(context);
    }
  }

  Widget _bannerMain(BuildContext context){
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: bgColor,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    uriLogo!,
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: txtColor
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _bannerWithText(BuildContext context){
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: bgColor,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    uriLogo!,
                    width: MediaQuery.of(context).size.width * 0.45,
                    color: txtColor
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text!,
                  style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      color: txtColor
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
