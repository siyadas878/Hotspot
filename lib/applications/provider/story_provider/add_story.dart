import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddStory extends ChangeNotifier {
  Future<void> addStory(
      String imgUrl, String uid, String time) async {
    try {
      CollectionReference postsCollection =
          FirebaseFirestore.instance.collection('story');

      String userId = FirebaseAuth.instance.currentUser!.uid;
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> postData = {
        'imgUrl': imgUrl,
        'id': uid,
        'time': time,
        'postId': id,
      };

      await postsCollection
          .doc(userId)
          .collection('this_user')
          .doc(id)
          .set(postData);

      imgUrl = '';
      notifyListeners();
    } catch (error) {
      log("Error adding post: $error");
    }
  }
}
