import 'package:flutter/material.dart';
import 'package:good_chat_new/theme/dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  void updateThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {

      updateThemeData(darkMode);
    } else {
      updateThemeData(lightMode);
    }
  }
}