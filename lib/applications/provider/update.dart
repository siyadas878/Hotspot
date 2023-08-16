import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/image_picker.dart';
import 'package:hotspot/applications/provider/update_user_details.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';
import '../../domain/user_model/user_model.dart';

class UpdateProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UpdateUser update = UpdateUser();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> updatedetails(BuildContext context, String imagePath) async {
    try {
      _isLoading = true;
      notifyListeners();
      ImageProviderClass imageclear = ImageProviderClass();
      final String name = nameController.text;
      final String username = usernameController.text;

      if (name.isEmpty ||
          username.isEmpty ) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      update.updateUserDetails(UserModel(
          name: name,
          username: username,
          imgpath: imagePath));

      // ignore: use_build_context_synchronously
      warning(context, 'Successfully signed up');
      nameController.clear();
      usernameController.clear();
      imageclear.clearImage();
      notifyListeners();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      warning(context, 'Error creating user: $error');
      print('Error creating user: $error');
    }
  }
}
