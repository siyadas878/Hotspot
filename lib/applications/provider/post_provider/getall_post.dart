import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../domain/post_model/post_model.dart';

class GetallPostProvider extends ChangeNotifier {
  List<PostModel> allposts = [];
  
  Future<List<PostModel>> getAllPosts() async {
    try {
      QuerySnapshot getusers =
          await FirebaseFirestore.instance.collection('uids').get();
      List<DocumentSnapshot> postsin = getusers.docs;

      for (var i = 0; i < postsin.length; i++) {
        var data = postsin[i];
        var uid = data['uid'];
        var userCollectionSnapshot = await FirebaseFirestore.instance
            .collection('posts')
            .doc(uid)
            .collection('this_user')
            .get();

        List<PostModel> posts = userCollectionSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return PostModel.fromJson(data);
        }).toList();

        posts.sort((a, b) => b.postId!.compareTo(a.postId!));
        allposts.addAll(posts);
        notifyListeners();
      }

      allposts.sort((a, b) => b.postId!.compareTo(a.postId!));
      notifyListeners();

      return allposts;
    } catch (e) {
      log('error-----$e');
    }
    

    return [];
  }

Future<PostModel?> getPost(String postid, String postuid) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postuid)
        .collection('this_user')
        .doc(postid)
        .get();

    if (postSnapshot.exists) {
      Map<String, dynamic> data = postSnapshot.data()!;
      PostModel post = PostModel.fromJson(data);

      return post;
    } else {
      log("Post not found");
      return null;
    }
  } catch (e) {
    log("Error fetching post: $e");
    return null;
  }
}


}
