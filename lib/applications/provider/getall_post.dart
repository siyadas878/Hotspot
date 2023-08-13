import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/domain/post_model/post_model.dart';

class GetallPostProvider extends ChangeNotifier {
  Future<List<PostModel>> getAllPosts() async {
    try {
      QuerySnapshot insidepost =
          await FirebaseFirestore.instance.collection('posts').get();
      print(insidepost.docs.length);
      List<PostModel> allposts = [];

      for (var element in insidepost.docs) {
        var userCollectionSnapshot = await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .collection('this_user')
            .get();
        List<PostModel> posts = userCollectionSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return PostModel.fromJson(data);
        }).toList();
        allposts.addAll(posts);
      }
      notifyListeners();
      print(allposts);
      return allposts;
    } catch (e) {
      print('error-----$e');
    }

    return [];
  }
}




// try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;

//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('posts')
//           .doc(userId)
//           .collection('this_user')
//           .get();

//       List<PostModel> posts = querySnapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return PostModel.fromJson(data);
//       }).toList();
//       notifyListeners();
//       return posts;
//     } catch (error) {
//       print("Error fetching posts: $error");
//     }