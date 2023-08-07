import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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

