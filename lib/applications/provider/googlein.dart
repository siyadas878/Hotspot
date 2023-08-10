import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/user_signup.dart';
import 'package:hotspot/domain/models/user_model/user_model.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';

class GoogleInProvider extends ChangeNotifier {
  
  AddUser adduser = AddUser();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> signUpUser(BuildContext context, String imagePath) async {
    try {
      final String name = nameController.text;
      final String username = usernameController.text;

      if (name.isEmpty ||
          username.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      adduser.addSignUpDetails(UserModel(
          name: name,
          username: username,
          imgpath: imagePath));

      // ignore: use_build_context_synchronously
      warning(context, 'Successfully signed up');

      nameController.clear();
      usernameController.clear();
      notifyListeners();
    } catch (error) {
      warning(context, 'Error creating user: $error');
    }
  }
}
