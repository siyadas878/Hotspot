import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/applications/provider/story_provider/add_story.dart';
import 'package:hotspot/applications/provider/story_provider/get_all_story.dart';
import 'package:hotspot/domain/story_model/story_model.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/post_provider/image_for_post.dart';
import '../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../core/constants/consts.dart';
import '../../../domain/user_model/user_model.dart';
import '../../widgets/space_with_height.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stories',
          style: GoogleFonts.jollyLodger(fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: size.height * 0.3,
                          ),
                          child: Consumer<PostImageProviderClass>(
                            builder: (context, value, child) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        value.imageUrl ??
                                            'https://static.thenounproject.com/png/396915-200.png',
                                        width: size.width * 0.3,
                                        height: size.height * 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SpaceWithHeight(size: size),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              value.getImageCamera(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: tealColor,
                                          ),
                                          child: const Text(
                                            'Camera',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.04),
                                        ElevatedButton(
                                          onPressed: () => value
                                              .getImageFromGallery(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: tealColor,
                                          ),
                                          child: const Text(
                                            'Gallery',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        String uid = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();
                                        try {
                                          Provider.of<AddStory>(context,
                                                  listen: false)
                                              .addStory(
                                            value.imageUrl!,
                                            uid,
                                            DateTime.now().toString(),
                                          );
                                        } catch (e) {
                                          log('$e');
                                        }
                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          value.clearImage();
                                        });
                                        Navigator.pop(context);
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
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: SafeArea(
        child: Consumer<GetallStoryProvider>(
          builder: (context, value, child) {
            return FutureBuilder<List<StoryModel>>(
              future: GetallStoryProvider().getAllStories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return GridView.builder(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              image: DecorationImage(
                                image:
                                    NetworkImage(snapshot.data![index].imgUrl!),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: FutureBuilder<UserModel?>(
                              future: GetProfileData()
                                  .getUserData(snapshot.data![index].id!),
                              builder: (context, usersnapshot) {
                                if (usersnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            usersnapshot.data!.imgpath!),
                                        radius: 20,
                                      ),
                                      Text('  ${usersnapshot.data!.username!}',
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.white))
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          },
          // child:
        ),
      ),
    );
  }
}
