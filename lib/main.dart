import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
import 'package:hotspot/applications/provider/theme_provider/theme_provider.dart';
import 'package:hotspot/presentation/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'applications/provider/message_provider/message_provider.dart';
import 'infrastructure/push_notification.dart';

String serverKey='AAAAI8CcaFs:APA91bGfdBvfWfrFRkwmoeUcc6QYArKGBp4fa0-fzXmWDXAAri0L3-0noHveUq_UK_jCuI2HOzNM8qZmoKDfxLlLJYq1CDn5cjgP40BTQ3UdnHxQOAl5VHN-BcA0BGThOi_Z--wu7-VI';

Future<void> _firebaseMessagingBackGroudHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroudHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroudHandler);
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
    LocalNotificationService.storeToken();
  }

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
