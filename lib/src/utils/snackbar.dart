import 'package:flutter/material.dart';
import 'package:go_up/src/utils/colors.dart' as utils;
class Snackbar{
  static void showSnackbar(BuildContext context, GlobalKey<ScaffoldState> key, String text){
    if(context == null) return;
    if(key == null) return;
    if(key.currentState == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14
        ),
      ),
      backgroundColor: utils.Colors.colorAppBase,
      duration: Duration(seconds: 3)
    ));
    
  }
}