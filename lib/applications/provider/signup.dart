import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotspot/applications/provider/user_signup.dart';
import 'package:hotspot/domain/models/user_model/user_model.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';

class SignUpProvider extends ChangeNotifier {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AddUser adduser = AddUser();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpUser(BuildContext context, String imagePath) async {
    try {
      final String name = nameController.text;
      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      if (name.isEmpty ||
          username.isEmpty ||
          email.isEmpty ||
          password.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        warning(context, 'Please enter a valid email address.');
        return;
      }

      if (password.length < 6) {
        warning(context, 'Password must be at least 6 characters long.');
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      adduser.addSignUpDetails(UserModel(
          name: name,
          email: email,
          password: password,
          username: username,
          imgpath: imagePath));

      // ignore: use_build_context_synchronously
      warning(context, 'Successfully signed up');
      nameController.clear();
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      notifyListeners();
    } catch (error) {
      warning(context, 'Error creating user: $error');
    }
  }
}
