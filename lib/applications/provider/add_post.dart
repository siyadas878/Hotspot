import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPost extends ChangeNotifier {
  Future<void> addPost(String imgUrl, String caption) async {
    try {
      CollectionReference postsCollection =
          FirebaseFirestore.instance.collection('posts');

      String userId = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> postData = {'imgUrl': imgUrl, 'caption': caption};

      String id = DateTime.now().millisecondsSinceEpoch.toString();

      await postsCollection
          .doc(userId)
          .collection('this_user')
          .doc(id)
          .set(postData);

      // Clear image URL and caption after successfully adding post
      imgUrl = ''; // Assuming imgUrl is a parameter, make sure it's mutable
      caption = '';
      notifyListeners();

    } catch (error) {
      log("Error adding post: $error");
    }
  }
}
