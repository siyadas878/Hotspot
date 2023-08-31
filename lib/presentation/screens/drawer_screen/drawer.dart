import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/main.dart';
import 'package:hotspot/presentation/screens/login_screen/login_screen.dart';
import 'package:hotspot/presentation/screens/splash_screen/splash_screen.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import '../../../domain/user_model/user_model.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<UserModel?>(
            future: GetProfileData().getUserData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Center(child: Text('User not found'));
              }

              final UserModel user = snapshot.data!;
              return Container(
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  color: tealColor,
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(75)),
                        border: Border.all(
                          color: Colors.white,
                          width: 7.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              user.imgpath.toString()), // Use user's image path
                        ),
                      ),
                    ),
                    SpaceWithHeight(size: size),
                    Text(
                      user.username.toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
              );
            },
          ),
          SpaceWithHeight(size: size),
          ListTile(
            leading: const Icon(FontAwesomeIcons.themeco),
            title: const Text('Theme'),
            trailing: Switch(
              activeColor: Colors.teal,
              focusColor: tealColor,
              value: true,
              onChanged: (value) {},
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.book),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.share),
            title: const Text('Share App'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.newspaper),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rightFromBracket),
            title: const Text('LogOut'),
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete'),
                  content: const Text('Do yo want to LogOut'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('LOGOUT'),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const MyApp()),
                            (route) => false,
                          );
                        } catch (e) {
                          warning(context, e.toString());
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
