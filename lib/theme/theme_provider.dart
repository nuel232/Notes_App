import 'package:flutter/material.dart';

import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  //initially, theme is light mode
  ThemeData _themeData = lightMode;

  //GETTER METHOD TO ACCESS THE THE FROM OTHER PARTS OF THE CODE
  ThemeData get themeData => _themeData;

  //GETTER METHOD TO SEE IF WE ARE IN DARK MODE OR NOT
  bool get isDarkMode => _themeData == DarkMode;

  //SETTER METHOD TO GET HTE NEW THEME
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //WE WILL USE THIS TOGGLE IN A SWITCH LATER ON...
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = DarkMode;
    } else {
      themeData = lightMode;
    }
  }
}
