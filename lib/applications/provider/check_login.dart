import 'package:flutter/material.dart';

class ScreenStateProvider with ChangeNotifier {
  bool _isScreenActive = false;

  bool get isScreenActive => _isScreenActive;

  void setScreenActive(bool value) {
    _isScreenActive = value;
    notifyListeners();
  }
}
