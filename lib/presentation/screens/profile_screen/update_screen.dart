import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/profile_provider/update.dart';
import 'package:hotspot/presentation/screens/nav_screen/nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/signup_provider/image_picker.dart';
import '../../../core/constants/consts.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/space_with_height.dart';
import '../../widgets/teal_login_button.dart';
import '../../widgets/text_field.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({
    Key? key,
    required this.existingImage,
  }) : super(key: key);

  final String existingImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<ImageProviderClass>(
          create: (context) => ImageProviderClass(),
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
                            backFunction: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavScreen(),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const AppLogo(size: 50,head: 'hotspot',color: Colors.black),
                    const Text(
                      'Update your account',
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
                          onTap: () => imagepic.getImageFromGallery(context,excistingimg: existingImage),
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
                                  : Image.network(
                                      existingImage,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller:
                            context.read<UpdateProvider>().nameController,
                        labelText: "name"),
                    SpaceWithHeight(size: size),
                    RoundedTealTextFormField(
                        controller:
                            context.read<UpdateProvider>().usernameController,
                        labelText: "username"),
                    SpaceWithHeight(size: size),
                    TealLoginButton(
                        onPressed: () async {
                          try {
                           await context.read<UpdateProvider>().updatedetails(
                                context,
                                imagepath:imagepic.imageUrl.toString(),
                                nameController:context
                                    .read<UpdateProvider>()
                                    .nameController
                                    .text,
                                usernameController:context
                                    .read<UpdateProvider>()
                                    .usernameController
                                    .text
                                    );
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        text: 'Update',
                        isLoading:
                            Provider.of<UpdateProvider>(context).isLoading),
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
