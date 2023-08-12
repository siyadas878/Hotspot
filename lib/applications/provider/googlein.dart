import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/user_signup.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';
import '../../domain/user_model/user_model.dart';

class GoogleInProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AddUser adduser = AddUser();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> signUpUser(BuildContext context, String imagePath) async {
    try {
      _isLoading = true;
      notifyListeners();

      final String name = nameController.text;
      final String username = usernameController.text;

      if (name.isEmpty || username.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      adduser.addSignUpDetails(
          UserModel(name: name, username: username, imgpath: imagePath));

      // ignore: use_build_context_synchronously
      warning(context, 'Successfully signed up');

      nameController.clear();
      usernameController.clear();
      notifyListeners();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      warning(context, 'Error creating user: $error');
    }
  }
}
