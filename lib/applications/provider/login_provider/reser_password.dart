// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../presentation/widgets/snackbar_warning.dart';

class ResetPassword extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final String email = emailController.text;

      if (email.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        warning(context, 'Please enter a valid email address.');
        return;
      }

      await _auth.sendPasswordResetEmail(email: email);

      warning(context, 'Check your email and reset password');



      _isLoading = false;
      notifyListeners();
    } catch (error) {
      log('Error: $error');
      warning(context, 'An error occurred. Please try again.');
      _isLoading = false;
      notifyListeners();
    }
  }
}
