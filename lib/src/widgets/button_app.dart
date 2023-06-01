import 'package:flutter/material.dart';
import 'package:go_up/src/utils/colors.dart' as utils;

class ButtonApp extends StatelessWidget {
  //const ButtonApp({Key? key}) : super(key: key);

  Color? color;
  String? text;
  Color? textColor;
  IconData? icon;
  Function? onPressed;

  ButtonApp({super.key,
    this.color = utils.Colors.colorAppBase,
    this.textColor = utils.Colors.colorAppBase,
    this.icon = Icons.arrow_forward_ios,
    this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: TextStyle(fontSize: 20, color: textColor),
      backgroundColor: color
    );
    return ElevatedButton(
      onPressed:(){
        onPressed!();
      },
      style: style,
      child:Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              )
            ),
          ),
          /*Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(
                  color: utils.Colors.colorAppBase,
                  icon
                ),
              ),
            ),
          ),*/
        ]
      ),
    );
  }
}
