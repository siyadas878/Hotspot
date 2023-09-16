import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../domain/coment_model/coment_model.dart';
import '../notification_provider/notification_provider.dart';

class LikeComentProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController commentCntrl = TextEditingController();
  bool? isTrue;

  Future<void> postComment(
      String postId, String postUserId, String thisUserId) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      await firestore
          .collection('posts')
          .doc(postUserId)
          .collection('this_user')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .set({
        'commentId': id,
        'commentedUserId': thisUserId,
        'comment': commentCntrl.text,
        'time': DateTime.now(),
      });
      final notificationProvider = NotificationProvider();
        await notificationProvider.addNotification(postUserId, 'comment on your post');
      commentCntrl.clear();
      notifyListeners();
    } catch (e) {
      log('Error posting comment: $e');
    }
  }

  Future<List<Coment>> fetchCommentsForPost(
      String uniqueIdOfPost, String postId) async {
    List<Coment> comments = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('posts')
        .doc(postId)
        .collection('this_user')
        .doc(uniqueIdOfPost)
        .collection('comments')
        .get();

    comments = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Coment(
        commentId: data['commentId'],
        commentedUserId: data['commentedUserId'],
        comment: data['comment'],
        time: data['time'].toDate().toString(),
      );
    }).toList();

    return comments;
  }

  Future<void> deleteComent(String postId,String uniqueIdOfPost,String id)async{
    try {
      await firestore
        .collection('posts')
        .doc(postId)
        .collection('this_user')
        .doc(uniqueIdOfPost)
        .collection('comments').doc(id).delete();
        notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
