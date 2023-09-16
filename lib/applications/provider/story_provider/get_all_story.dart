import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../domain/story_model/story_model.dart';

class GetallStoryProvider extends ChangeNotifier {
  List<StoryModel> allposts = [];
  
  Future<List<StoryModel>> getAllStories() async {
    try {
      QuerySnapshot getusers =
          await FirebaseFirestore.instance.collection('uids').get();
      List<DocumentSnapshot> postsin = getusers.docs;

      

      for (var i = 0; i < postsin.length; i++) {
        var data = postsin[i];
        var uid = data['uid'];
        var userCollectionSnapshot = await FirebaseFirestore.instance
            .collection('story')
            .doc(uid)
            .collection('this_user')
            .get();

        List<StoryModel> posts = userCollectionSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return StoryModel.fromJson(data);
        }).toList();

        posts.sort((a, b) => b.storyId!.compareTo(a.storyId!));
        allposts.addAll(posts);
        notifyListeners();
      }

      return allposts;
    } catch (e) {
      log('error-----$e');
    }
    

    return [];
  }

Future<StoryModel?> getStory(String postid, String postuid) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore.instance
        .collection('story')
        .doc(postuid)
        .collection('this_user')
        .doc(postid)
        .get();

    if (postSnapshot.exists) {
      Map<String, dynamic> data = postSnapshot.data()!;
      StoryModel post = StoryModel.fromJson(data);

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
