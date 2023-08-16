import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeComentProvider extends ChangeNotifier {
  bool? isTrue;

  Future<void> likePost(
    String userId,
    String postId,
    List<String> likes,
    String id,
  ) async {
    try {
      final postRef = FirebaseFirestore.instance.collection('posts').doc(id);

      if (likes.contains(userId)) {
        await postRef.collection('this_user').doc(postId).update({
          'like': FieldValue.arrayRemove([userId]),
        });
        isTrue = false;
        notifyListeners();
      } else {
        await postRef.collection('this_user').doc(postId).update({
          'like': FieldValue.arrayUnion([userId]),
        });
        isTrue = true;
        notifyListeners();
      }
    } catch (e) {
      log('error--------- $e');
    }
  }
}
