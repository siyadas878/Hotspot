import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../domain/user_model/user_model.dart';

class AddUser extends ChangeNotifier {
  UserModel? data;
  AddUser({this.data});

  Future<void> addSignUpDetails(UserModel data) async {
    try {
      UserModel user = UserModel(
          name: data.name,
          username: data.username,
          email: data.email,
          imgpath: data.imgpath,
          password: data.password,
          uid: data.uid,
          followers: [],
          following: []);

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      String userr = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> userData = user.toJson();

      await usersCollection.doc(userr.toString()).set(userData);

     
    } catch (error) {
      log("Error adding user: $error");
    }
  }
}
