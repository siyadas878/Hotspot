import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageProviderClass extends ChangeNotifier {
  String? _imgPath;
  String? get imgPath => _imgPath;
  String? imageUrl;

  void clearImage() {
    _imgPath = null;
    notifyListeners();
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        _imgPath = image!.path;
        notifyListeners();

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference rootImage = storage.ref().child('image');
        Reference uploadImage = rootImage.child(fileName);

        await uploadImage.putFile(File(image.path));

        imageUrl = await uploadImage.getDownloadURL();
        notifyListeners();
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }
}
