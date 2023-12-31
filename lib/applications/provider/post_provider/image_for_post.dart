import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostImageProviderClass extends ChangeNotifier {
  String? _imgPath;
  String? get imgPath => _imgPath;
  String? imageUrl;
  bool isloading=false;

  void clearImage() {
    _imgPath = null;
    imageUrl = null;
    notifyListeners();
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      isloading=true;
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        _imgPath = image!.path;
        notifyListeners();

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference rootImage = storage.ref().child('post_image');
        Reference uploadImage = rootImage.child(fileName);

        await uploadImage.putFile(File(image.path));

        imageUrl = await uploadImage.getDownloadURL();
        isloading=false;
        notifyListeners();
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }

  Future<void> getImageCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      isloading=true;
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        _imgPath = image!.path;
        notifyListeners();

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference rootImage = storage.ref().child('post_image');
        Reference uploadImage = rootImage.child(fileName);

        await uploadImage.putFile(File(image.path));

        imageUrl = await uploadImage.getDownloadURL();
        isloading=false;
        notifyListeners();
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }
}
