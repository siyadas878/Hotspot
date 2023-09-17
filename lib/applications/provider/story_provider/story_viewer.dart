import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StorieControllerProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  double precent = 0.0;

  void startTime() {
    Timer.periodic(const Duration(milliseconds: 3), (timer) {
      precent += 0.001;
      if (precent > 1) {
        timer.cancel();
      }
      notifyListeners();
    });
  }
}