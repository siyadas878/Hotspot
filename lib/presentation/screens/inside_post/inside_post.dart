import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/post_provider/like_provider.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/applications/provider/post_provider/coment_provider.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/domain/coment_model/coment_model.dart';
import 'package:hotspot/domain/user_model/user_model.dart';
import 'package:hotspot/presentation/screens/inside_post/widgets/coment_textfield.dart';
import 'package:hotspot/presentation/screens/user_screen/user_screen.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/post_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../applications/provider/post_provider/getall_post.dart';
import '../../../applications/provider/theme_provider/theme_provider.dart';

class InsidePost extends StatelessWidget {
  final String imageUrl;
  final String userId;
  final String uniqueIdOfPost;
  final String time;
  final String caption;

  const InsidePost({
    Key? key,
    required this.imageUrl,
    required this.userId,
    required this.uniqueIdOfPost,
    required this.time,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    DateTime postDateTime = DateTime.parse(time);
    return Scaffold(
      appBar: const MyAppBar(title: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () => showImageViewer(
                              context, Image.network(imageUrl.toString()).image,
                              swipeDismissible: true, doubleTapZoomable: true),
                          child: Container(
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const PostShimmerList();
                            }
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data!.imgpath.toString()),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserScreen(uid: userId),
                                        ),
                                      );
                                    },
                                    child: Text(snapshot.data!.username!),
                                  ),
                                  Text(
                                    caption,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: FutureBuilder(
                                future: GetallPostProvider()
                                    .getPost(uniqueIdOfPost, userId),
                                builder: (context, postsnapshot) {
                                  if (postsnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Consumer<LikeProvider>(
                                    builder: (context, likeProvider, _) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: size.width * 0.02),
                                          FutureBuilder(
                                            future: GetallPostProvider()
                                                .getPost(
                                                    uniqueIdOfPost, userId),
                                            builder: (context, likesnapshot) {
                                              if (likesnapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }
                                              return Row(
                                                children: [
                                                  Text(
                                                    postsnapshot
                                                        .data!.like!.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.01,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await likeProvider
                                                          .likePost(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        uniqueIdOfPost,
                                                        likesnapshot
                                                            .data!.like!,
                                                        userId,
                                                      );
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: likesnapshot
                                                              .data!.like!
                                                              .contains(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          ? tealColor
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(width: size.width * 0.05),
                                          InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                  FontAwesomeIcons.comment)),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Comments',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                              .read<ThemeProvider>()
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              Text(
                                timeago
                                    .format(postDateTime, allowFromNow: true)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        context.read<ThemeProvider>().isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.45,
                      child: Consumer<LikeComentProvider>(
                        builder: (context, value, child) {
                          return FutureBuilder<List<Coment>>(
                            future: value.fetchCommentsForPost(
                              uniqueIdOfPost,
                              userId,
                            ),
                            builder: (context, comentsnapshot) {
                              if (comentsnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (comentsnapshot.hasError) {
                                return Text('Error: ${comentsnapshot.error}');
                              } else if (!comentsnapshot.hasData ||
                                  comentsnapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('No comments yet'),
                                );
                              } else {
                                List<Coment> comments = comentsnapshot.data!;
                                return ListView.builder(
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    Coment comment = comments[index];
                                    DateTime comentTime =
                                        DateTime.parse(comment.time!);
                                    return GestureDetector(
                                      onLongPress: () {
                                        if (comentsnapshot
                                                .data![index].commentedUserId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Delete'),
                                              content: const Text(
                                                  'Do yo want to delete'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('CANCEL',
                                                      style: TextStyle(
                                                          color: tealColor)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    'DELETE',
                                                    style: TextStyle(
                                                        color: tealColor),
                                                  ),
                                                  onPressed: () async {
                                                    context
                                                        .read<
                                                            LikeComentProvider>()
                                                        .deleteComent(
                                                            comentsnapshot
                                                                .data![index]
                                                                .commentedUserId!,
                                                            uniqueIdOfPost,
                                                            comentsnapshot
                                                                .data![index]
                                                                .commentId!);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title:
                                              Text(comment.comment.toString()),
                                          subtitle: Text(
                                            timeago.format(comentTime,
                                                allowFromNow: true),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: context
                                                        .read<ThemeProvider>()
                                                        .isDarkMode
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          leading: FutureBuilder<UserModel?>(
                                            future: GetProfileData()
                                                .getUserData(
                                                    comment.commentedUserId!),
                                            builder: (context, userimage) {
                                              if (userimage.hasData &&
                                                  userimage.data != null) {
                                                final userImage =
                                                    userimage.data!;
                                                final imgPath =
                                                    userImage.imgpath;
                                                return CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(imgPath!),
                                                );
                                              } else {
                                                return const Text(
                                                    'No user data available');
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ComentTextField(
                          uniqueIdOfPost: uniqueIdOfPost, userId: userId),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
