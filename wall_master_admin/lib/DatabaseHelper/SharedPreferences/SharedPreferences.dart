import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wall_master_admin/Models/AdminModel.dart';

class SharedPref {
  static const String _keyUser = 'AdminData';

  static Future<void> saveUser(AdminModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = user.toJson();
    await prefs.setString(_keyUser, userJson);
  }

  static Future<AdminModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return AdminModel.fromJson(userJson);
    }
    return null;
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
