import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/domain/post_model/post_model.dart';
import '../../domain/user_model/user_model.dart';

class GetProfileData extends ChangeNotifier {
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<int> postcount() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(userId)
        .collection('this_user')
        .get();

    List<PostModel> posts = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return PostModel.fromJson(data);
    }).toList();
    return posts.length;
  }

  Future<List<PostModel>> getposts(String uid) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('this_user')
          .get();

      List<PostModel> posts = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostModel.fromJson(data);
      }).toList();
      notifyListeners();
      return posts;
    } catch (e) {
      log('errror--$e');
    }
    return [];
  }
}
