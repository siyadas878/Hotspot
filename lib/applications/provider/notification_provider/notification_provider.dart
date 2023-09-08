import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/domain/notification_model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {

     List<NotificationModel> allNotifications = [];


  addNotification(String toId, String status) async {
    String fromId = FirebaseAuth.instance.currentUser!.uid;
    String docId = DateTime.now().millisecondsSinceEpoch.toString();

    NotificationModel data = NotificationModel(
        fromId: fromId,
        id: docId,
        status: status,
        time: DateTime.now().toString(),
        userId: toId);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('notifications');

    Map<String, dynamic> userData = data.toJson();

    await usersCollection.doc(toId.toString()).collection('user').add(userData);
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
     
        var userCollectionSnapshot = await FirebaseFirestore.instance
            .collection('notifications')
            .doc(uid)
            .collection('user')
            .orderBy('time', descending: true)
            .get();

        List<NotificationModel> posts = userCollectionSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return NotificationModel.fromJson(data);
        }).toList();

        for (var element in posts) {
          if (element.fromId==uid) {
            continue;
          }else{
            allNotifications.add(element);
            notifyListeners();
          }
        }

     return allNotifications;
    } catch (e) {
      log('error-----$e');
    }
    

    return [];
  }

}
