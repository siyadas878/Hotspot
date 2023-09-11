import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
 ThemeData lightTheme = ThemeData.light().copyWith(
  
  appBarTheme: const AppBarTheme(
    color: Colors.teal,
  ),
  primaryColor: Colors.teal,
  focusColor: tealColor,
  hintColor: tealColor,
  highlightColor: tealColor,
  primaryColorLight: tealColor,
  primaryColorDark: tealColor,
  progressIndicatorTheme:const ProgressIndicatorThemeData(color: tealColor),
);
  ThemeData darkTheme = ThemeData.dark();

  bool isDarkMode = false;

  ThemeData get currentTheme => isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> initializeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}
