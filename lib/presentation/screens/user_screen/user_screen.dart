import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/post_provider/follow_provider.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/domain/post_model/post_model.dart';
import 'package:hotspot/presentation/screens/inside_post/inside_post.dart';
import 'package:hotspot/presentation/widgets/follow_icon.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/consts.dart';
import '../../../domain/user_model/user_model.dart';

class UserScreen extends StatelessWidget {
  final String uid;
  const UserScreen({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<UserModel?>(
      future: GetProfileData().getUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Center(child: Text('User not found'));
        }

        final UserModel user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.42,
                  decoration: const BoxDecoration(
                    color: tealColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(75)),
                          border: Border.all(
                            color: Colors.white,
                            width: 7.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => showImageViewer(context,
                                Image.network(user.imgpath.toString()).image,
                                swipeDismissible: true,
                                doubleTapZoomable: true),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage:
                                  NetworkImage(user.imgpath.toString()),
                            ),
                          ),
                        ),
                      ),
                      SpaceWithHeight(size: size),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.name.toString(),
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Consumer<FollowProvider>(
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () async {
                                  await context
                                      .read<FollowProvider>()
                                      .followfollowing(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          uid);
                                },
                                child: FollowIcon(
                                  size: size,
                                  name: user.followers!.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? "Unfollow"
                                      : 'Follow',
                                  color: tealColor,
                                  backgroundcolor: Colors.white,
                                ),
                              );
                            },
                            // child:
                          )
                        ],
                      ),
                      SpaceWithHeight(size: size),
                      FutureBuilder(
                        future: GetProfileData().getposts(uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildNumberContainer(
                                5,
                                'Followers',
                                context,
                              ),
                              SizedBox(width: size.width * 0.03),
                              buildNumberContainer(
                                snapshot.data!.length,
                                'Posts',
                                context,
                              ),
                              SizedBox(width: size.width * 0.03),
                              buildNumberContainer(
                                3,
                                'Following',
                                context,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                  child: FutureBuilder<List<PostModel>>(
                    future: GetProfileData().getposts(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available.'));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InsidePost(
                                      imageUrl: snapshot.data![index].imgUrl
                                          as String,
                                      userId: uid,
                                      uniqueIdOfPost:
                                          snapshot.data![index].postId!,
                                      time: snapshot.data![index].time!,
                                      caption: snapshot.data![index].caption!,
                                    ),
                                  )),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data![index].imgUrl as String),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.teal,
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      }
                    },
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

buildNumberContainer(int number, String title, BuildContext context) {
  var size = MediaQuery.of(context).size;

  return Container(
    width: size.width * 0.18,
    height: size.height * 0.09,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2.0, //
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              number.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
