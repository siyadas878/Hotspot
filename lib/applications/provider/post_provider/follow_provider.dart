import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../notification_provider/notification_provider.dart';

class FollowProvider extends ChangeNotifier {
  bool isfollow = false;

  Future<void> followfollowing(String userId, String otherUserId) async {
    final postRef = FirebaseFirestore.instance.collection('users');

    final followinglist =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final List<dynamic> following = followinglist['following'];

    try {
      if (following.contains(otherUserId)) {
        await postRef.doc(otherUserId).update({
          'followers': FieldValue.arrayRemove([userId]),
        });
        await postRef.doc(userId).update({
          'following': FieldValue.arrayRemove([otherUserId]),
        });
        isfollow = false;
        notifyListeners();
      } else {
        await postRef.doc(otherUserId).update({
          'followers': FieldValue.arrayUnion([userId]),
        });
        await postRef.doc(userId).update({
          'following': FieldValue.arrayUnion([otherUserId]),
        });
        final notificationProvider = NotificationProvider();
        await notificationProvider.addNotification(otherUserId, 'strarted following you');
        isfollow = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<bool> followings(String userId, String otherUserId) async {
    final followinglist =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final List<dynamic> following = followinglist['following'];
    if (!following.contains(otherUserId)) {
      return false;
    }
    return true;
  }
}
