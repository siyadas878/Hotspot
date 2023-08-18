import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/post_provider/like_provider.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/inside_post/inside_post.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../domain/user_model/user_model.dart';
import '../../widgets/app_bar.dart';
import '../drawer_screen/drawer.dart';
import '../message/message_screen.dart';
import 'package:hotspot/applications/provider/post_provider/getall_post.dart';
import 'package:hotspot/domain/post_model/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: MyAppBar(
        title: 'Hotspot',
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MessageScreen()),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.facebookMessenger,
            color: Colors.teal,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<PostModel>>(
          future: GetallPostProvider().getAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final posts = snapshot.data!;

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final imageUrl = post.imgUrl!;

                  return ChangeNotifierProvider(
                    create: (context) => LikeProvider(),
                    child: PostWidget(
                      size: size,
                      imageUrl: imageUrl,
                      postId: posts[index].postId ?? '',
                      like: posts[index].like!,
                      userId: posts[index].userId!,
                      uniqueIdOfPost: posts[index].postId!,
                      time: posts[index].time!,
                      caption: posts[index].caption!,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget(
      {Key? key,
      required this.size,
      required this.imageUrl,
      required this.postId,
      required this.like,
      required this.userId,
      required this.uniqueIdOfPost,
      required this.time,
      required this.caption})
      : super(key: key);
  final String postId;
  final Size size;
  final String imageUrl;
  final List like;
  final String userId;
  final String uniqueIdOfPost;
  final String time;
  final String caption;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<LikeProvider>().initial(
            userId: userId,
            postId: postId,
          );
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 217, 217),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InsidePost(
                          imageUrl: imageUrl,
                          userId: userId,
                          uniqueIdOfPost: uniqueIdOfPost,
                          time: time,
                          caption: caption),
                    ));
              },
              child: Container(
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            FutureBuilder<UserModel?>(
              future: GetProfileData().getUserData(userId),
              builder: (context, snapshot) {
                DateTime postDateTime = DateTime.parse(time);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('User not found'));
                }
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data!.imgpath.toString()),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.username!),
                      Text(
                        timeago
                            .format(postDateTime, allowFromNow: true)
                            .toString(),
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  trailing: Consumer<LikeProvider>(
                    builder: (context, likeProvider, _) {
                      List<String> updatedLikeList = List.from(like);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(updatedLikeList.length.toString()),
                          SizedBox(width: size.width * 0.02),
                          Consumer<LikeProvider>(
                            builder: (context, value, child) {
                              return InkWell(
                              onTap: () async {
                                await value.likePost(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      postId,
                                      updatedLikeList,
                                      userId,
                                    );
                              },
                              child: Icon(
                                value.isLiked
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: value.isLiked ? tealColor : null,
                              ),
                            );
                            },
                            // child: 
                          ),

                          SizedBox(width: size.width * 0.05),

                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InsidePost(
                                        imageUrl: imageUrl,
                                        userId: userId,
                                        uniqueIdOfPost: uniqueIdOfPost,
                                        time: time,
                                        caption: caption,
                                      ),
                                    ));
                              },
                              child: const Icon(FontAwesomeIcons.comment)),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
