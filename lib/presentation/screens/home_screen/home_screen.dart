import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../applications/provider/get_data_in_profile.dart';
import '../../../domain/user_model/user_model.dart';
import '../../widgets/app_bar.dart';
import '../drawer_screen/drawer.dart';
import '../message/message_screen.dart';
import 'package:hotspot/applications/provider/getall_post.dart';
import 'package:hotspot/domain/post_model/post_model.dart';

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
                  return PostWidget(size: size, imageUrl: imageUrl);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// Rest of your code

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.size,
    required this.imageUrl,
  }) : super(key: key);

  final Size size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 217, 217),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
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
            FutureBuilder<UserModel?>(
              future: GetProfileData().getUserData(uid),
              builder: (context, snapshot) {
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
                  title:  Text(snapshot.data!.username!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(FontAwesomeIcons.heart),
                      SizedBox(width: size.width * 0.05),
                      const Icon(FontAwesomeIcons.message),
                    ],
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
