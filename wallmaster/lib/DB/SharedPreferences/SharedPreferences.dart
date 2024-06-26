import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/Model/UserModel.dart';

class SharedPref {
  static const String _keyUser = 'wallmaster_user';
    static const String _keyLanguageUser = 'wallmaster_user_language';
    static const String _keyWorkManager = 'wallmaster_work_manager';

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = user.toJson();
    await prefs.setString(_keyUser, userJson);
  }


  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }


  //Selected Language Saving
    static Future<void> saveSelectedLanguage(value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyLanguageUser, value);
  }

    static Future<String?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString(_keyLanguageUser);
    if (language != null) {
      return language;
    }
    return null;
  }

    static Future<void> removeSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLanguageUser);
  }


  //Creating to check that work manager service is enabled or not
  static Future<void> setWorkManager(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final magazine = value;
    await prefs.setBool(_keyWorkManager,magazine);
  }

  static Future<bool> getWorkManager() async {
    final prefs = await SharedPreferences.getInstance();
    final magazine = prefs.getBool(_keyWorkManager);
    if (magazine != null) {
      return magazine;
    }
    return false;
  }

  // static Future<>
}
