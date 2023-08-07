import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/nav_bar.dart';
import 'package:hotspot/presentation/screens/sign_up_screen.dart';
import 'package:hotspot/presentation/widgets/app_logo.dart';
import 'package:hotspot/presentation/widgets/teal_login_button.dart';
import 'package:hotspot/presentation/widgets/text_field.dart';
import '../widgets/back_arrow.dart';
import '../widgets/space_with_height.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BackArrow(
                    size: size, backFunction: () => Navigator.pop(context)),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.08),
          const AppLogo(size: 50),
          const Text('Log In your account',
              style: TextStyle(color: tealColor, fontSize: 13)),
          SpaceWithHeight(size: size),
          RoundedTealTextFormField(
              controller: emailController, labelText: 'Email'),
          SpaceWithHeight(size: size),
          RoundedTealTextFormField(
              controller: emailController, labelText: 'Password'),
          SpaceWithHeight(size: size),
          const Text('Forgot your password?',
              style: TextStyle(
                color: tealColor,
                fontSize: 13,
              )),
          SpaceWithHeight(size: size),
          TealLoginButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NavScreen(),));
          }, text: 'Login'),
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
          Container(
            width: size.width*0.7,
            height: size.height*0.06,
            decoration: BoxDecoration(
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
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold 
                      ),
                ),
                const Text(
                  'Login with google',
                ),
              ],
            ),
          ),
          SpaceWithHeight(size: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don’t have account? Let’s '),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: tealColor),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
