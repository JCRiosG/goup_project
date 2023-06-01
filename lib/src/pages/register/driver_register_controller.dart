import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_up/src/models/client.dart';
import 'package:go_up/src/providers/firebase/auth_provider.dart';
import 'package:go_up/src/providers/firebase/client_provider.dart';
import 'package:go_up/src/utils/my_progress_dialog.dart';
import 'package:go_up/src/utils/snackbar.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:go_up/src/providers/api_connection/api_connection.dart';
import 'package:go_up/src/utils/my_progress_dialog.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class DriverRegisterController{
  BuildContext? context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();

  AuthProvider? _authProvider;
  late ClientProvider _clientProvider;
  late ProgressDialog _progressDialog;

  Future? init(BuildContext context){
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Cargando...')!;
  }

  void registerFirebase() async{
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();

    if(username.isEmpty && email.isEmpty && password.isEmpty && confirmPassword.isEmpty){
      print('El usuario debe ingresar todos los campos');
      utils.Snackbar.showSnackbar(context!, key, 'El usuario debe ingresar todos los campos');
      return;
    }

    if(confirmPassword != password){
      print('Las contraseñas no coinciden');
      utils.Snackbar.showSnackbar(context!, key, 'Las contraseñas no coinciden');
      return;
    }

    if(password.length < 6){
      print('El password debe tener por lo menos 6 caracteres');
      utils.Snackbar.showSnackbar(context!, key, 'El password debe tener por lo menos 6 caracteres');
      return;
    }

    _progressDialog.show();

    try{
      bool? isRegister = await _authProvider?.register(email, password);
      if(isRegister!){
        Client client = Client(
          id: _authProvider!.getUser()!.uid,
          username: username,
          email: _authProvider!.getUser()!.email.toString(),
          password: password
        );
        await _clientProvider.create(client);
        _progressDialog.hide();
        print("El usuario se registro correctamente");
        utils.Snackbar.showSnackbar(context!, key, 'El usuario se registro correctamente');
      }else{
        _progressDialog.hide();
        print("El usuario no se pudo registrar");
        utils.Snackbar.showSnackbar(context!, key, 'El usuario no se pudo registrar');
      }
    }catch(e){
      _progressDialog.hide();
      print("Error: $e");
      utils.Snackbar.showSnackbar(context!, key, 'Error: $e');
    }
  }


}