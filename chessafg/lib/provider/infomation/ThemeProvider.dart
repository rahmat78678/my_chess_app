


import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _textSize = 14.0;
  String _language = 'English';

  ThemeMode get themeMode => _themeMode;
  double get textSize => _textSize;
  String get language => _language;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setTextSize(double newSize) {
    _textSize = newSize;
    notifyListeners();
  }

  void setLanguage(String newLang) {
    _language = newLang;
    notifyListeners();
  }
  
}
