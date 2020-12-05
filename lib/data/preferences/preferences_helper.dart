import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const NOTIFICATION = 'NOTIFICATION';

  Future<bool> get isSwitched async {
    final prefs = await sharedPreferences;
    return prefs.getBool(NOTIFICATION) ?? false;
  }

  void setNotificationStatus(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(NOTIFICATION, value);
  }
}
