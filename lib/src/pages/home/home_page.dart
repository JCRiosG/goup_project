import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_up/src/pages/home/home_controller.dart';
import 'package:go_up/src/utils/colors.dart' as utils;
import 'package:go_up/src/widgets/backgroun_app.dart';
import 'package:go_up/src/widgets/button_app.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);
  final HomeController _con = HomeController();
  @override
  Widget build(BuildContext context) {
    _con.init(context);
    return Scaffold(
      backgroundColor: utils.Colors.appColorGris,
      body: SafeArea(

        child: Stack(
          children: [
            BgApp(text: 'Welcome!',),
            Container(
              //color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.25, horizontal: MediaQuery.of(context).size.width * 0.1),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05, horizontal: MediaQuery.of(context).size.width * 0.07),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: utils.Colors.colorAppBase,
                    width: 0.8
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(4, 4)
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buttonLogin('admin','Administrador'),
                  _buttonLogin('driver', 'Conductor'),
                  _buttonLogin('user', 'Usuario')
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _buttonLogin(String typeUser, String txt){
    return Container(
        //margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: ButtonApp(
          color : utils.Colors.appColorNaranja,
          textColor : utils.Colors.colorAppBase,
          onPressed: ()=>_con.goToLoginPage(typeUser),
          text: txt,
        )
    );
  }
}
