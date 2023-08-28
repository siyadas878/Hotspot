import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../applications/provider/post_provider/like_provider.dart';
import '../../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../../core/constants/consts.dart';
import '../../../../domain/user_model/user_model.dart';
import '../../inside_post/inside_post.dart';
import '../../user_screen/user_screen.dart';

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
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(uid: userId),));
                        },
                        child: Text(snapshot.data!.username!)),
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
                              child: Icon(FontAwesomeIcons.solidHeart,                                    
                                color: value.isLiked ? tealColor : null,
                              ),
                            );
                            },
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
