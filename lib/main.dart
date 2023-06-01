import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_up/src/pages/home/home_page.dart';
import 'package:go_up/src/pages/login/login_page.dart';
import 'package:go_up/src/pages/maps/maps_page.dart';
import 'package:go_up/src/pages/register/client_register_page.dart';
import 'package:go_up/src/pages/register/driver_register_page.dart';
import 'package:go_up/src/pages/maps/client_map_page.dart';
import 'package:go_up/src/utils/colors.dart' as utils;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GO UP',
      initialRoute: 'mapCliente',
      theme: ThemeData(
        fontFamily: 'Anton',
        appBarTheme: const AppBarTheme(
          elevation: 0
        ),
        primaryColor: utils.Colors.appColorGris
      ),
      routes: {
        'home':(BuildContext context) => HomePage(),
        'login':(BuildContext context) => LoginPage(),
        'client_register':(BuildContext context) => ClientRegisterPage(),
        'driver_register':(BuildContext context) => DriverRegisterPage(),
        'maps':(BuildContext context) => mapWebViewApp(),
        'mapCliente':(BuildContext context) => ClientMapPage()
      },
    );
  }
}
