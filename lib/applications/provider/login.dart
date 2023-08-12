import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotspot/presentation/screens/nav_bar.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final String email = emailController.text;
      final String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        warning(context, 'Please enter a valid email address.');
        return;
      }

      if (password.length < 6 || password.isEmpty) {
        warning(context, 'Password must be at least 6 characters long.');
        return;
      }

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emailController.clear();
      passwordController.clear();
      notifyListeners();

      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavScreen(),
            ),
            (route) => false); 
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      warning(context, 'Invalid email or password. Please try again.');
    }
  }
}
