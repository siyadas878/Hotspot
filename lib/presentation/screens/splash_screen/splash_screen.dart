import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/presentation/screens/login_screen/login_screen.dart';
import 'package:hotspot/presentation/screens/nav_bar.dart';
import '../../widgets/app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    wait(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[500],
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo(size: 50),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.51,
              right: size.width * 0.367,
              child: const Text(
                'make connections',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
                top: size.height * 0.42,
                right: size.width * 0.35,
                child: const Icon(
                  FontAwesomeIcons.message,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

wait(context) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  await Future.delayed(const Duration(milliseconds: 3700));
  auth.currentUser?.uid != null
      ? Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavScreen()))
      : Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
}
