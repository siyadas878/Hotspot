import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UidOfMessages extends ChangeNotifier {
  addUidOfMessage(String currentUserId,String receviersId) async{
    var firestore=FirebaseFirestore.instance;
    DocumentSnapshot snap =
        await firestore.collection('chat_users').doc(currentUserId).get();
    List chatingList = (snap.data() as dynamic)['uid'];
    if (chatingList.contains(receviersId)) {
      await firestore.collection('chat_users').doc(currentUserId).update({
        'uid': FieldValue.arrayRemove([receviersId])
      });
      await firestore.collection('chat_users').doc(currentUserId).update({
        'uid': FieldValue.arrayUnion([receviersId])
      });
      await firestore.collection('chat_users').doc(receviersId).update({
        'uid': FieldValue.arrayRemove([currentUserId])
      });
      await firestore.collection('chat_users').doc(receviersId).update({
        'uid': FieldValue.arrayUnion([currentUserId])
      });
    } else {
      await firestore.collection('chat_users').doc(currentUserId).update({
        'uid': FieldValue.arrayUnion([receviersId])
      });
      await firestore.collection('chat_users').doc(receviersId).update({
        'uid': FieldValue.arrayUnion([currentUserId])
      });
    }
  }
}