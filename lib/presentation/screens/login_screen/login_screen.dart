import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/applications/provider/login_provider/login.dart';
import 'package:hotspot/applications/provider/theme_provider/theme_provider.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/infrastructure/functions/google_login.dart';
import 'package:hotspot/presentation/screens/signup_screen/sign_up_screen.dart';
import 'package:hotspot/presentation/widgets/app_logo.dart';
import 'package:hotspot/presentation/widgets/teal_login_button.dart';
import 'package:hotspot/presentation/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../../../infrastructure/push_notification.dart';
import '../../../main.dart';
import '../../widgets/space_with_height.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: size.height * 0.14),
            const AppLogo(size: 50, head: 'hotspot', color: Colors.black),
            const Text('Log In your account',
                style: TextStyle(color: tealColor, fontSize: 13)),
            SpaceWithHeight(size: size),
            RoundedTealTextFormField(
              controller: Provider.of<LoginProvider>(context).emailController,
              labelText: 'Email',
            ),
            SpaceWithHeight(size: size),
            RoundedTealTextFormField(
              controller:
                  Provider.of<LoginProvider>(context).passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            SpaceWithHeight(size: size),
            const Text('Forgot your password?',
                style: TextStyle(
                  color: tealColor,
                  fontSize: 13,
                )),
            SpaceWithHeight(size: size),
            TealLoginButton(
              onPressed: () {
                final loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);

                loginProvider.loginUser(context);

                FirebaseMessaging.onBackgroundMessage(
                    firebaseMessagingBackGroudHandler);
                FirebaseMessaging.instance.getInitialMessage();
                FirebaseMessaging.onMessage.listen((message) {
                  LocalNotificationService.display(message);
                });
                LocalNotificationService.storeToken();
              },
              text: 'Login',
              isLoading: Provider.of<LoginProvider>(context).isLoading,
            ),
            SpaceWithHeight(size: size),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Row(children: [
                Expanded(
                    child: Divider(
                  color: tealColor,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Or With",
                      style: TextStyle(
                        color: tealColor,
                        fontSize: 13,
                      )),
                ),
                Expanded(
                    child: Divider(
                  color: tealColor,
                )),
              ]),
            ),
            SpaceWithHeight(size: size),
            InkWell(
              onTap: () {
                signinWithGoogle(context: context);
              },
              child: Container(
                width: size.width * 0.7,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: tealColor,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(
                    color: tealColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G  ',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Login with google',
                    ),
                  ],
                ),
              ),
            ),
            SpaceWithHeight(size: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have account? Let’s ',
                  style: TextStyle(
                      color: context.read<ThemeProvider>().isDarkMode
                          ? Colors.grey
                          : Colors.black),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: tealColor),
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
