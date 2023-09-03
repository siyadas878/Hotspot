import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
    ),
    primaryColor: Colors.teal,
    primaryColorLight: tealColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: 'archivoNarrow', color: Colors.black),
      titleMedium: TextStyle(fontFamily: 'archivoNarrow', color: Colors.black),
      titleSmall: TextStyle(fontFamily: 'archivoNarrow', color: Colors.black),
    ),
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
