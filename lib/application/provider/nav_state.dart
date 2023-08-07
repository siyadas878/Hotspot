import 'package:flutter/material.dart';

class NavBAr extends ChangeNotifier {
  int currentIndex = 0;

  void onNavIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}