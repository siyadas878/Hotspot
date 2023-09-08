import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImageProviderClass extends ChangeNotifier {
  String? _imgPath;
  String? get imgPath => _imgPath;
  String? imageUrl;
  int? fileBytes;

  void clearImage() {
    _imgPath = null;
    notifyListeners();
  }

  Future<void> getImageFromGallery(BuildContext context,{String? excistingimg}) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {

        _imgPath = image!.path;
        notifyListeners();

        fileBytes = await getFileSize(image.path);
        notifyListeners();

        if (fileBytes != null && fileBytes! > 1000000) {
          imageUrl=excistingimg;
          notifyListeners();
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('warning'),
              content: const Text('The selected image exceeds 1MB.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          FirebaseStorage storage = FirebaseStorage.instance;
          Reference rootImage = storage.ref().child('image');
          Reference uploadImage = rootImage.child(fileName);

          await uploadImage.putFile(File(image.path));

          imageUrl = await uploadImage.getDownloadURL();
          notifyListeners();
        }
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }
}

Future<int> getFileSize(String path) async {
  final fileBytes = await File(path).readAsBytes();
  return fileBytes.lengthInBytes;
}
