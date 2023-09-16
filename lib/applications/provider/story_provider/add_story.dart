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
        'storyId': id,
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
  Future<void> autodeletStory() async {
    final sdata = await FirebaseFirestore.instance.collection('story').get();
    for (var element in sdata.docs) {
      Timestamp time = element['time'];
      int now = DateTime.now().millisecondsSinceEpoch;
      final duration = now - time.millisecondsSinceEpoch;
      // 86400000
      if (duration > 86400000) {
        await FirebaseFirestore.instance
            .collection("story")
            .doc(element['storyId'])
            .delete();
      }
    }
  }
}
