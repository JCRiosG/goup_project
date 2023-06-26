import 'package:flutter/material.dart';
import 'package:go_up/src/utils/shared_pref.dart';

class HomeController{
  BuildContext? context;
  SharedPref? _sharedPref;

  Future? init(BuildContext context) async {
    this.context = context;
    _sharedPref = SharedPref();
  }

  void goToLoginPage(String typeUser){
    saveTypeUser(typeUser);
    Navigator.pushNamed(context!, 'login');
  }

  void goToMapPage(){
    Navigator.pushNamed(context!, 'maps');
  }

  void saveTypeUser(String typeUser) async{
    await _sharedPref!.save('typeUser', typeUser);
  }

}