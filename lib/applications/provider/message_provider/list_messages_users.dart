import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../domain/user_model/user_model.dart';

class ListMessagedUsers extends ChangeNotifier {
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;
  int? listLength;

 Future<List<UserModel>> getMessagedUsers() async {
  List<UserModel> allusers = [];

  try {
    final DocumentSnapshot<Map<String, dynamic>> userUIDsSnapshot =
        await FirebaseFirestore.instance
            .collection('chat_users')
            .doc(currentUser)
            .get();
    final Map<String, dynamic> data = userUIDsSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> uidList = data['uid'] as List<dynamic>;
    final List<String> uids = uidList.map((uid) => uid.toString()).toList();
    listLength = uids.length;

    for (final uid in uids) {
      if (uid != currentUser) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          final UserModel user = UserModel.fromJson(userData);
          allusers.add(user);
        }
      }
    }

    return allusers;
  } catch (e) {
    log('Error fetching messaged users: $e');
    return []; // Return an empty list in case of an error.
  }
}

}
