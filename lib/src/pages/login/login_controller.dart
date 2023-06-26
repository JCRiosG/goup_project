import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_up/src/providers/firebase/auth_provider.dart';
import 'package:go_up/src/utils/my_progress_dialog.dart';
import 'package:go_up/src/utils/shared_pref.dart';
import 'package:go_up/src/utils/snackbar.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:go_up/src/providers/api_connection/api_connection.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class LoginController{
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  late ProgressDialog _progressDialog;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthProvider? _authProvider;
  SharedPref? _sharedPref;
  String? _typeUser;

  Future? init(BuildContext context) async{
    this.context = context;
    _authProvider = AuthProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Cargando...')!;
    _sharedPref = SharedPref();
    _typeUser= await _sharedPref!.read('typeUser');
    //print('============ TIPO DE USUARIO ============');
    //print(_typeUser);
    if(_typeUser == 'driver'){
      Navigator.pushNamed(context!, 'mapConductor');
    }
    if(_typeUser == 'user'){
      Navigator.pushNamed(context!, 'mapCliente');
    }

    return null;
  }

  void loginFirebase() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    _progressDialog.show();
    try{
      bool? isLogin = await _authProvider?.login(email, password);
      if(isLogin!){
        utils.Snackbar.showSnackbar(context!, key, 'El usuario esta logeado');
        //print("El usuario esta logeado");
      }else{
        utils.Snackbar.showSnackbar(context!, key, 'El usuario no se pudo autenticar');
        //print("El usuario no se pudo autenticar");
      }
      _progressDialog.hide();
    }catch(e){
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context!, key, 'Error: $e');
      //print("Error: $e");
    }
  }

  void loginHttp() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    _progressDialog.show();
    try{
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'email':email,
          'pass':password
        }
      );
      if(res.statusCode == 200){
        var resBody = jsonDecode(res.body);
        if(resBody['emailFound']){
          utils.Snackbar.showSnackbar(context!, key, 'El email ya esta siendo usado. Intenta con otro');
          //Fluttertoast.showToast(msg: "Email is already in someone else use. Try another email.");
        }else{
          utils.Snackbar.showSnackbar(context!, key, 'Algo paso');
          //Fluttertoast.showToast(msg: "Algo paso");
        }
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(context!, key, resBody);
        //print(resBody);
      }
      _progressDialog.hide();
    }catch(e){
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context!, key, '$e : Error');
      //Fluttertoast.showToast(msg: "$e : Error");
    }
  }

  void goToRegisterPage(){
    Navigator.pushNamed(context!, _typeUser! + '_register');
  }
}