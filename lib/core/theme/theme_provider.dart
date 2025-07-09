import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*

To load the theme, we will use SharedPreferences.
Flow: 
  1. On app launch, it will call the ThemeProvider
  2. Theme provider will load the theme.
  3. It will read a stored value if found else it will set to a default value.
  4. UI builds with the theme value
  5. On toggle, it will call a toggle method
  6. This method will change the current value and save it. 
  7. Save the new value. Here we will use SharedPreferences to store a bool.
  8. Call load method to read the theme and notify listners.
  9. UI rebuilts with new value.

*/

class ThemeProvider extends ChangeNotifier {
  // declare default
  bool _isDarkTheme = true;

  // getter
  bool get isDarkTheme => _isDarkTheme;

  // constructor
  ThemeProvider() {
    _loadTheme();
  }

  // load theme with default value
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? true;
    _saveTheme();
    notifyListeners();
  }

  // save them in memory
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  // toggle theme and save in memory.
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme();
    notifyListeners();
  }
}
