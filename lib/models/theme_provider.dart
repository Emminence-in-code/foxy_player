import 'package:flutter/material.dart';
import 'package:foxy_player/themes/dark_mode.dart';
import 'package:foxy_player/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  //Gettters
  ThemeData get themeData => _themeData;
//check for dark mode
  bool get isDarkMode => _themeData == darkMode;
  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  //toggle theme

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
