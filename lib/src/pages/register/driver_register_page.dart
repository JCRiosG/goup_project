import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_up/src/pages/register/driver_register_controller.dart';
import 'package:go_up/src/utils/colors.dart' as utils;
import 'package:go_up/src/widgets/button_app.dart';
import 'package:go_up/src/widgets/banner_app.dart';

class DriverRegisterPage extends StatefulWidget {
  //const loginPage({Key? key}) : super(key: key);

  @override
  _DriverRegisterPageState createState() => _DriverRegisterPageState();
}

class _DriverRegisterPageState extends State<DriverRegisterPage> {

  DriverRegisterController _con = new DriverRegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        backgroundColor: utils.Colors.colorAppBase
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _bannerApp(),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.17),
              _textFieldUsername(),
              _textFieldEmail(),
              _textFieldPass(),
              _textFieldConfirmPass(),
              _buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerApp(){
    return BannerApp(
        bgColor: utils.Colors.colorAppBase,
        text: 'Registro\n Colaborador',
        txtColor: Colors.white);
      /*ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.colorAppBase,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.start,
          children:[
            Image.asset(
                'assets/images/3.png',
                width: 300,
                height: 300,
                color: Colors.white
            ),
            const Text(
              'Registro\n Conductor',
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                color:Colors.white
              ),
            )
          ],
        ),
      ),
    );*/
  }

  Widget _textFieldUsername(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _con.usernameController,
        decoration: const InputDecoration(
          hintText: 'gerardoTorres',
          labelText: 'Nombre de Usuario',
          suffixIcon: Icon(
            Icons.person_outline,
            color: utils.Colors.colorAppBase
          )
        )
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
          controller: _con.emailController,
          decoration: const InputDecoration(
              hintText: 'correo@gmail.com',
              labelText: 'correo electronico',
              suffixIcon: Icon(
                  Icons.email_outlined,
                  color: utils.Colors.colorAppBase
              )
          )
      ),
    );
  }

  Widget _textFieldPass(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        obscureText: true,
        controller: _con.passwordController,
        decoration: const InputDecoration(
          labelText: 'Constraseña',
          suffixIcon: Icon(
            Icons.lock_open_outlined,
            color: utils.Colors.colorAppBase
          )
        )
      ),
    );
  }

  Widget _textFieldConfirmPass(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
          obscureText: true,
          controller: _con.confirmController,
          decoration: const InputDecoration(
              labelText: 'Confirmar Constraseña',
              suffixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: utils.Colors.colorAppBase
              )
          )
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.registerFirebase,
        text: 'Registrar Ahora',
        color: utils.Colors.colorAppBase,
        textColor: Colors.white,
      )
    );
  }
}
