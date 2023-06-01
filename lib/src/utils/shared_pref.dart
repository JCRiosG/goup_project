import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{

  Future<void> save(String key, String value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  Future<bool> constains(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}