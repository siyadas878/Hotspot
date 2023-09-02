import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/message_provider/messageuid_collection.dart';
import '../../../domain/message_model/message_model.dart';

class MessageCreationProvider extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  UidOfMessages adduid=UidOfMessages();

  Future<void> addMessage(String fromId) async {
    String addinguid = fromId + userId;
    List<String> charList = addinguid.split('');
    charList.sort();
    String uniqueId = charList.join();

    try {
      MessageModel message = MessageModel(
        fromId: fromId,
        message: messageController.text,
        messageId: uniqueId,
        time: DateTime.now().toString(),
        userId: userId,
      );

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('chat');

      Map<String, dynamic> messageData = message.toJson();

      await usersCollection
          .doc(uniqueId)
          .set({'id': uniqueId, 'fromId': fromId, 'userId': userId});

      await usersCollection
          .doc(uniqueId)
          .collection('messages')
          .add(messageData);

      Timer(const Duration(seconds: 1), () {
        messageController.clear();
        notifyListeners();
      });
      adduid.addUidOfMessage(userId, fromId);
    } catch (error) {
      log("Error adding message: $error");
    }
  }

  Future<List<MessageModel>> getAllMessages(String fromId) async {
    List<MessageModel> allmessages = [];
    String addinguid = fromId + userId;
    List<String> charList = addinguid.split('');
    charList.sort();
    String uniqueId = charList.join();

    try {
      var userCollectionSnapshot = await FirebaseFirestore.instance
          .collection('chat')
          .doc(uniqueId)
          .collection('messages')
          .orderBy('time', descending: false)
          .get();

      List<MessageModel> message = userCollectionSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return MessageModel.fromJson(data);
      }).toList();

      allmessages = message;
      
      notifyListeners();
      return allmessages;
    } catch (e) {
      log('Error getting messages: $e');
    }

    return [];
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

}