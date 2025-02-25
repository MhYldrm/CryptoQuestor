import 'package:crypto_questor/product/init/theme/project_theme.dart';
import 'package:flutter/material.dart';

/// [ProjectThemeViewModel] A class that manages the theme of the application.
/// It provides functionality to switch between dark and light themes and notifies listeners about theme changes.
///
class ProjectThemeViewModel with ChangeNotifier {
  /// The current theme of the app, initially set to dark theme.
  ThemeData _themeData = darkTheme;

  /// Getter for the current theme.
  /// Returns the current theme (dark or light).
  ThemeData get themeData => _themeData;

  /// Setter for the theme.
  /// Sets the theme to a new value and notifies listeners about the change.
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// Changes the theme of the app.
  /// If the current theme is dark, it switches to light theme.
  /// If the current theme is light, it switches to dark theme.
  void changeTheme() {
    _themeData = _themeData == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
