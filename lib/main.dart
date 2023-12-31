// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/login_provider/reser_password.dart';
import 'package:hotspot/applications/provider/message_provider/list_messages_users.dart';
import 'package:hotspot/applications/provider/message_provider/messageuid_collection.dart';
import 'package:hotspot/applications/provider/post_provider/add_post.dart';
import 'package:hotspot/applications/provider/post_provider/follow_provider.dart';
import 'package:hotspot/applications/provider/post_provider/like_provider.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/applications/provider/post_provider/getall_post.dart';
import 'package:hotspot/applications/provider/login_provider/googlein.dart';
import 'package:hotspot/applications/provider/post_provider/image_for_post.dart';
import 'package:hotspot/applications/provider/post_provider/coment_provider.dart';
import 'package:hotspot/applications/provider/login_provider/login.dart';
import 'package:hotspot/applications/provider/navbar_provider/nav_state.dart';
import 'package:hotspot/applications/provider/search_provider/search_provider.dart';
import 'package:hotspot/applications/provider/signup_provider/signup.dart';
import 'package:hotspot/applications/provider/profile_provider/update.dart';
import 'package:hotspot/applications/provider/profile_provider/update_user_details.dart';
import 'package:hotspot/applications/provider/signup_provider/user_signup.dart';
import 'package:hotspot/applications/provider/story_provider/add_story.dart';
import 'package:hotspot/applications/provider/story_provider/get_all_story.dart';
import 'package:hotspot/applications/provider/theme_provider/theme_provider.dart';
import 'package:hotspot/presentation/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'applications/provider/message_provider/message_provider.dart';
import 'applications/provider/story_provider/story_viewer.dart';
import 'infrastructure/push_notification.dart';

Future<void> firebaseMessagingBackGroudHandler(RemoteMessage message) async {
  print("Handling background message: ${message.data.toString()}");
  print("Notification: ${message.notification!.toString()}");
  LocalNotificationService.display(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  LocalNotificationService.storeToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroudHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NavBAr(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoogleInProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SignUpProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetProfileData(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddUser(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddPost(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostImageProviderClass(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetallPostProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UpdateUser(),
          ),
          ChangeNotifierProvider(
            create: (context) => UpdateProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LikeComentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetallUsersProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FollowProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => MessageCreationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ListMessagedUsers(),
          ),
          ChangeNotifierProvider(
            create: (context) => UidOfMessages(),
          ),
          ChangeNotifierProvider(
            create: (context) => LikeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddStory(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetallStoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ResetPassword(),
          ),
          ChangeNotifierProvider(
            create: (context) => StorieControllerProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: value.currentTheme,
              home: const SplashScreen(),
            );
          },
        ));
  }
}
