import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/add_post.dart';
import 'package:hotspot/applications/provider/image_for_post.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/consts.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});

  final TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(title: '    Add Post'),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<PostImageProviderClass>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(value.imageUrl ??
                              'https://img.freepik.com/premium-vector/photo-camera-vector-icon-neumorphism-style-vector-eps-10_532800-803.jpg?w=360'),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                          color: tealColor, width: 2), // Adding border
                    ),
                  ),
                  SpaceWithHeight(size: size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => value.getImageCamera(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealColor,
                        ),
                        child: const Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      ElevatedButton(
                        onPressed: () => value.getImageFromGallery(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealColor,
                        ),
                        child: const Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SpaceWithHeight(size: size),
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color: tealColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: captionController,
                      style: const TextStyle(color: tealColor),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        labelText: 'Caption',
                        hintText: 'Caption',
                        labelStyle: TextStyle(color: tealColor, fontSize: 14),
                        hintStyle: TextStyle(color: tealColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SpaceWithHeight(size: size),
                  ElevatedButton(
                    onPressed: () {
                      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
                      try {
                        Provider.of<AddPost>(context, listen: false)
                            .addPost(value.imageUrl!, 
                            captionController.text,
                            uid,DateTime.now().toString());
                      } catch (e) {
                        log('$e');
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        value.clearImage();
                        captionController.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
