import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../applications/provider/post_provider/follow_provider.dart';
import '../../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../../applications/provider/search_provider/search_provider.dart';
import '../../../../core/constants/consts.dart';
import '../../../../domain/post_model/post_model.dart';
import '../../../widgets/follow_icon.dart';
import '../../user_screen/user_screen.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    return FutureBuilder<List<PostModel>>(
        future: GetProfileData().getposts(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
          return  Consumer<GetallUsersProvider>(
              builder: (context, value, child) {
                return FutureBuilder<void>(
                  future: value.getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching data'));
                    } else {
                      final userList = value.allusers;

                      if (userList.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }

                      return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final user = userList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(user.imgpath.toString()),
                            ),
                            title: Text(user.username!),
                            subtitle: Text(user.name!),
                            trailing: Consumer<FollowProvider>(
                              builder: (context, value, child) {
                                String userId = FirebaseAuth
                                    .instance.currentUser!.uid
                                    .toString();
                                String otherUserId =
                                    userList[index].uid.toString();
                                return InkWell(
                                  onTap: () {
                                    Provider.of<FollowProvider>(context,
                                            listen: false)
                                        .followfollowing(userId, otherUserId);
                                  },
                                  child: FollowIcon(
                                    size: size,
                                    name:
                                        value.isfollow ? 'Following' : 'Follow',
                                    color: Colors.white,
                                    backgroundcolor: tealColor,
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserScreen(uid: user.uid.toString()),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        });
  }
}
