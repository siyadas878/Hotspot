import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../domain/user_model/user_model.dart';

class UpdateUser extends ChangeNotifier {
    bool isLoading = false;

  UserModel? data;
  UpdateUser({this.data});

  Future<void> updateUserDetails(String name,String username,String imgpath) async {
    try {
     isLoading = true;
      notifyListeners();

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      String userId = FirebaseAuth.instance.currentUser!.uid;

      await usersCollection.doc(userId).update(
        {
          'name':name,
          'username':username,
          'imgpath':imgpath
        }
      );
      isLoading=false;
      notifyListeners();
    } catch (error) {
      log("Error adding/updating user: $error");
    }
  }
}
