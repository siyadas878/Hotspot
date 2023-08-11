import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/signup.dart';
import '../../../core/constants/consts.dart';
import '../../../applications/provider/image_picker.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/space_with_height.dart';
import '../../widgets/teal_login_button.dart';
import '../../widgets/text_field.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<ImageProviderClass>(
          create: (context) =>
              ImageProviderClass(), // Provide the instance here
          child: Consumer<ImageProviderClass>(
            builder: (context, imagepic, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: BackArrow(
                            size: size,
                            backFunction: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const AppLogo(size: 50),
                    const Text(
                      'Create your account',
                      style: TextStyle(color: tealColor, fontSize: 13),
                    ),
                    SpaceWithHeight(size: size),
                    Container(
                      width: size.width * 0.3,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: tealColor),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () => imagepic.getImageFromGallery(context),
                          child: ClipOval(
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.15,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: imagepic.imgPath != null
                                  ? Image.file(
                                      File(imagepic.imgPath!),
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(
                                        FontAwesomeIcons.userTie,
                                        size: 50,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller:
                            Provider.of<SignUpProvider>(context).nameController,
                        labelText: 'name'),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller: Provider.of<SignUpProvider>(context)
                            .usernameController,
                        labelText: 'username'),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller: Provider.of<SignUpProvider>(context)
                            .emailController,
                        labelText: 'email'),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller: Provider.of<SignUpProvider>(context)
                            .passwordController,
                        labelText: 'Password',
                        obscureText: true),
                    SpaceWithHeight(size: size),
                    TealLoginButton(
                      onPressed: () async {
                        final signUpProvider =
                            Provider.of<SignUpProvider>(context, listen: false);

                        signUpProvider.signUpUser(
                            context, imagepic.imageUrl.toString());

                      },
                      text: 'Sign Up',
                      isLoading:
                    Provider.of<SignUpProvider>(context).isLoading,
                    ),
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
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
