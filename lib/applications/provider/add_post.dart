import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPost extends ChangeNotifier {
  Future<void> addPost(
      String imgUrl, String caption, String uid, String time) async {
    try {
      CollectionReference postsCollection =
          FirebaseFirestore.instance.collection('posts');

      String userId = FirebaseAuth.instance.currentUser!.uid;
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> postData = {
        'imgUrl': imgUrl,
        'caption': caption,
        'id': uid,
        'time': time,
        'postId':id,
        'like': []
      };

      await postsCollection
          .doc(userId)
          .collection('this_user')
          .doc(id)
          .set(postData);

      imgUrl = '';
      caption = '';
      notifyListeners();
    } catch (error) {
      log("Error adding post: $error");
    }
  }
}
