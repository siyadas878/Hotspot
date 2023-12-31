import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/applications/provider/profile_provider/update.dart';
import 'package:hotspot/domain/post_model/post_model.dart';
import 'package:hotspot/presentation/screens/drawer_screen/drawer.dart';
import 'package:hotspot/presentation/screens/inside_post/inside_post.dart';
import 'package:hotspot/presentation/screens/profile_screen/update_screen.dart';
import 'package:hotspot/presentation/screens/profile_screen/widgets/follow_bottomsheet.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/consts.dart';
import '../../../domain/user_model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

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
          appBar: MyAppBar(
            title: user.username.toString(),
            trailing: IconButton(
              onPressed: () {
                context.read<UpdateProvider>().nameController.text = user.name!;
                context.read<UpdateProvider>().usernameController.text =
                    user.username!;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                        existingImage: user.imgpath.toString(),
                      ),
                    ));
              },
              icon: const Icon(FontAwesomeIcons.userPen, color: Colors.white),
            ),
          ),
          drawer: DrawerScreen(),
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
                      Text(
                        user.name.toString(),
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
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
                          return FutureBuilder<UserModel?>(
                            future: GetProfileData().getUserData(uid),
                            builder: (context, usersnapshot) {
                              if (usersnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                              return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildNumberContainer(
                                  usersnapshot.data!.followers!.length,
                                  'Followers',
                                  context,
                                  (){
                                    followersbottomSheet(context,usersnapshot.data!.followers!);
                                  }
                                ),
                                SizedBox(width: size.width * 0.03),
                                buildNumberContainer(
                                  snapshot.data!.length,
                                  'Posts',
                                  context,
                                  (){
                                    Null;
                                  }
                                ),
                                SizedBox(width: size.width * 0.03),
                                buildNumberContainer(
                                  usersnapshot.data!.following!.length,
                                  'Following',
                                  context,
                                  (){
                                    followersbottomSheet(context,usersnapshot.data!.following!);
                                  }
                                ),
                              ],
                            );
                            },
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
                  child: Consumer<GetProfileData>(
                    builder: (context, profilevalue, child) {
                      return FutureBuilder<List<PostModel>>(
                      future: profilevalue.getposts(uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
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
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Do yo want to delete'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('CANCEL',style: TextStyle(color: tealColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('DELETE',style: TextStyle(color: tealColor),),
                        onPressed: () async {
                          context.read<GetProfileData>().deletePost(uid, snapshot.data![index].postId!);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                                  ),
                                );
                                },
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
                                          caption:
                                              snapshot.data![index].caption!),
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
                    );
                    },
                    // child: 
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

buildNumberContainer(int number, String title, BuildContext context,Function function) {
  var size = MediaQuery.of(context).size;

  return InkWell(
    onTap: () => function(),
    child: Container(
      width: size.width * 0.18,
      height: size.height * 0.085,
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style:  TextStyle(fontSize: size.width*0.025, color: Colors.white),
              ),
              SizedBox(height: size.height*0.01,),
              Text(
                number.toString(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


