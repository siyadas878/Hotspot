import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../domain/story_model/story_model.dart';

class GetallStoryProvider extends ChangeNotifier {
  List<StoryModel> allposts = [];

  Future<List<StoryModel>> getAllStories() async {
    List<StoryModel> allstories = [];
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
        allstories.addAll(posts);
        notifyListeners();
      }

      for (var element in allstories) {
          int time = int.parse(element.storyId.toString());
          int now = DateTime.now().millisecondsSinceEpoch;
          final duration = now - time;
          if (duration > 86400000){
            await FirebaseFirestore.instance
            .collection('story')
            .doc(element.id)
            .collection('this_user').doc(element.storyId).delete();
          }else{
            allposts.add(element);
          }
        }
        allposts.sort((a, b) => b.storyId!.compareTo(a.storyId!));
      notifyListeners();

      return allposts;
    } catch (e) {
      log('error-----$e');
    }

    return [];
  }

}
