import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  bool isLiked = false;
  String lengthOfLike = '';

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
        isLiked = false;
        notifyListeners();
      } else {
        await postRef.collection('this_user').doc(postId).update({
          'like': FieldValue.arrayUnion([userId]),
        });
        isLiked = true;
        notifyListeners();
      }
    } catch (e) {
      log('error--------- $e');
    }
  }

  Future<void> initial({
    required String userId,
    required String postId,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      final postRef = await FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('this_user')
          .doc(postId)
          .get();

      final List<dynamic> list = postRef['like'];
      lengthOfLike = list.length.toString();
      notifyListeners();
      if (list.contains(user)) {
        isLiked = true;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
