import 'package:flutter/material.dart';

import '../../core/constants/consts.dart';
import '../widgets/app_logo.dart';
import '../widgets/back_arrow.dart';
import '../widgets/space_with_height.dart';
import '../widgets/teal_login_button.dart';
import '../widgets/text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

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
        const AppLogo(size: 50),
        const Text('Create your account',
            style: TextStyle(color: tealColor, fontSize: 13)),
        SpaceWithHeight(size: size),
        Container(
          width: size.width * 0.3,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: tealColor),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding:const EdgeInsets.all(
                5), 
            child: Container(
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                ),
              ),
            ),
          ),
        ),
        SpaceWithHeight(size: size),
        RoundedTealTextFormField(controller: name, labelText: 'name'),
        SpaceWithHeight(size: size),
        RoundedTealTextFormField(controller: username, labelText: 'username'),
        SpaceWithHeight(size: size),
        RoundedTealTextFormField(controller: email, labelText: 'email'),
        SpaceWithHeight(size: size),
        RoundedTealTextFormField(controller: email, labelText: 'Password'),
        SpaceWithHeight(size: size),
        TealLoginButton(onPressed: () {}, text: 'Sign Up'),
        SpaceWithHeight(size: size),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Le’s go to, '),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Login In',
                  style: TextStyle(color: tealColor),
                ))
          ],
        )
      ])),
    );
  }
}
