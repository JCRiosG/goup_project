import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_up/src/pages/login/login_controller.dart';
import 'package:go_up/src/utils/colors.dart' as utils;
import 'package:go_up/src/widgets/button_app.dart';

class LoginPage extends StatefulWidget {
  //const loginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

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
      /*appBar: AppBar(
        backgroundColor: utils.Colors.colorAppBase
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //_bannerApp(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              _textFieldEmail(),
              _textFieldPass(),
              _buttonLogin(),
              _textDontHaveAccount()
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerApp(){
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.colorAppBase,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children:[
            Image.asset(
                'assets/images/5.png',
                width: MediaQuery.of(context).size.width * 0.45,
                //height: 300,
                color: Colors.white
            ),
            const Text(
              'LogIn',
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                color:Colors.white
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05)
          ],
        ),
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

  Widget _buttonLogin(){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.loginFirebase,
        text: 'Iniciar Sesion',
        color: utils.Colors.colorAppBase,
        textColor: Colors.white,
      )
    );
  }
  Widget _textDontHaveAccount(){
    return GestureDetector(
      onTap: _con.goToRegisterPage,
      child: Container(
        margin: const EdgeInsets.only(bottom:50),
        child: const Text(
          'No tienes cuenta?, Registrate',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
      ),
    );
  }
}
