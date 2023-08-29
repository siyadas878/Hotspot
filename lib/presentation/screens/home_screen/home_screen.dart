import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/post_provider/like_provider.dart';
import 'package:hotspot/presentation/screens/home_screen/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar.dart';
import '../drawer_screen/drawer.dart';
import '../message/message_screen.dart';
import 'package:hotspot/applications/provider/post_provider/getall_post.dart';
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
