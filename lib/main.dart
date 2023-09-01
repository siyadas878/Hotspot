import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/applications/provider/message_provider/list_messages_users.dart';
import 'package:hotspot/applications/provider/post_provider/add_post.dart';
import 'package:hotspot/applications/provider/post_provider/follow_provider.dart';
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
import 'package:hotspot/presentation/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'applications/provider/message_provider/message_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          fontFamily: GoogleFonts.archivoNarrow().fontFamily,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
