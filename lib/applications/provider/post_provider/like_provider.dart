import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/notification_provider/notification_provider.dart';

class LikeProvider extends ChangeNotifier {
  bool isLiked = false;
  String lengthOfLike = '';
  List<String> postlikes = [];

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
        final notificationProvider = NotificationProvider();
        await notificationProvider.addNotification(id, 'liked your post');

        isLiked = true;
        notifyListeners();
      }

      postlikes.clear();
      postlikes.addAll(likes);

      notifyListeners();
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

      if (list.contains(user)) {
        isLiked = true;
      } else {
        isLiked = false;
      }

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
