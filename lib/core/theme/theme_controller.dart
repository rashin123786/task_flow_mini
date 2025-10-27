import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;
  ThemeData get currentTheme => _isDark ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
