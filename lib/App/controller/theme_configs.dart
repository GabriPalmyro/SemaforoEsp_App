import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfigs extends ChangeNotifier {
  ThemeConfigs() {
    initialise();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(newTheme) {
    _isDarkTheme = newTheme;
    notifyListeners();
  }

  Future<void> initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isDarkTheme = prefs.getBool('isDarkTheme');
      if (isDarkTheme == null) await prefs.setBool('isDarkTheme', false);
      isDarkTheme = false;
    } catch (e) {
      await prefs.setBool('isDarkTheme', false);
      isDarkTheme = false;
    }

    log(isDarkTheme.toString());
  }

  Future<void> changePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool('isDarktTheme', !isDarkTheme);
      isDarkTheme = !isDarkTheme;
    } catch (e) {
      log(e.toString());
    }

    log(isDarkTheme.toString());
  }
}
