// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';


class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("assets/logo.jpg"));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      print("In notification method");
      Random random =  Random();
      int id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("mychanel", "my chanel",
              importance: Importance.max, priority: Priority.high));

      print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print("erorr>>>>>>>>$e");
    }
  }

  static Future<void> sendNotification(
      {String? title, String? message, String? token}) async {
    print("\n\n\n\n\n\n\n\n");
    print("token is $token");
    print("\n\n\n\n\n\n\n\n");

    final data = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "satatus": "done",
      "message": message
    };
    try {
      http.Response r = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': message, 'title': title},
            'priority': 'high',
            'data': data,
            "to": "$token"
          },
        ),
      );
      print(r.body);
      if (r.statusCode == 200) {
        print("done");
      } else {
        print("\n\n\n\n\n\n\n\n");
        print("the erorr is this ${r.statusCode}");
        print("\n\n\n\n\n\n\n\n");
      }
    } catch (e) {
      print("Exception $e");
    }
  }

  static storeToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"fcmToken": token!}, SetOptions(merge: true));
    } catch (e) {
      print("erorr is $e");
    }
  }
}