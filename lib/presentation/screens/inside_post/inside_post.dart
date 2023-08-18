import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/applications/provider/post_provider/coment_provider.dart';
import 'package:hotspot/domain/coment_model/coment_model.dart';
import 'package:hotspot/domain/user_model/user_model.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class InsidePost extends StatelessWidget {
  final String imageUrl;
  final String userId;
  final String uniqueIdOfPost;
  final String time;
  final String caption;
  const InsidePost(
      {super.key,
      required this.imageUrl,
      required this.userId,
      required this.uniqueIdOfPost,
      required this.time,
      required this.caption});

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
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FutureBuilder<UserModel?>(
                    future: GetProfileData().getUserData(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState==ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data!.imgpath.toString()),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.username!),
                              Text(caption,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(FontAwesomeIcons.heart),
                              SizedBox(width: size.width * 0.05),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(FontAwesomeIcons.comment)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Comments'),
                          Text(
                            timeago
                                .format(postDateTime, allowFromNow: true)
                                .toString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.45,
                    color: Colors.white,
                    child: Expanded(
                      child: Consumer<LikeComentProvider>(
                        builder: (context, value, child) {
                          return FutureBuilder<List<Coment>>(
                            future: value.fetchCommentsForPost(
                                uniqueIdOfPost, userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No one commented'));
                              } else {
                                List<Coment> comments = snapshot.data!;
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    Coment comment = comments[index];
                                    DateTime comentTime = DateTime.parse(
                                        snapshot.data![index].time!);
                                    return SizedBox(
                                      height: size.height * 0.1,
                                      child: Center(
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(comment.comment.toString()),
                                              Text(
                                                timeago
                                                    .format(comentTime,
                                                        allowFromNow: true)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
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
                                                final imgPath = userImage
                                                    .imgpath; // Access imgpath safely
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        controller: Provider.of<LikeComentProvider>(context)
                            .commentCntrl,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const Icon(FontAwesomeIcons.penToSquare),
                          suffixIcon: InkWell(
                              onTap: () {
                                String thisUserId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                Provider.of<LikeComentProvider>(context,
                                        listen: false)
                                    .postComment(
                                        uniqueIdOfPost, userId, thisUserId);
                              },
                              child: const Icon(FontAwesomeIcons.paperPlane)),
                          hintText: 'Write your comment...',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
