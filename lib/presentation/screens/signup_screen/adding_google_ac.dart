import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/signup_provider/signup.dart';
import 'package:hotspot/presentation/screens/nav_screen/nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/login_provider/googlein.dart';
import '../../../core/constants/consts.dart';
import '../../../applications/provider/signup_provider/image_picker.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/space_with_height.dart';
import '../../widgets/teal_login_button.dart';
import '../../widgets/text_field.dart';

class GoogleUser extends StatelessWidget {
  const GoogleUser({Key? key}) : super(key: key);

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
                    SizedBox(height: size.height * 0.1),
                    const AppLogo(size: 50),
                    const Text(
                      'Add your Details',
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
                    TealLoginButton(
                        onPressed: () async {
                          Provider.of<SignUpProvider>(context, listen: false)
                              .signUpUser(
                                  context, imagepic.imageUrl.toString());

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavScreen(),
                              ),
                              (route) => false);
                        },
                        text: 'Add',
                        isLoading:
                            Provider.of<GoogleInProvider>(context).isLoading),
                    SpaceWithHeight(size: size),
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
