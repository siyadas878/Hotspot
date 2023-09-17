import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/post_provider/like_provider.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/home_screen/widgets/post_widget.dart';
import 'package:hotspot/presentation/screens/story_screen/story_screen.dart';
import 'package:hotspot/presentation/widgets/post_shimmer.dart';
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
        trailing: Row(
          children: [
            IconButton(
              onPressed: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoryScreen()),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.faceGrinStars,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessageScreen()),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.facebookMessenger,
                color: Colors.white,
              ),
            ),
            SizedBox(width: size.width*0.01,)
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<PostModel>>(
                      future: GetallPostProvider().getAllPosts(),
                      builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PostShimmerList();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final posts = snapshot.data!;
              
                  return RefreshIndicator(
                    color: tealColor,
                    onRefresh: () => context.read<GetallPostProvider>().getAllPosts(),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final imageUrl = post.imgUrl!;
                        return ChangeNotifierProvider(
                          create: (context) => LikeProvider(),
                          child: PostWidget(
                            size: size,
                            imageUrl: imageUrl,
                            like: posts[index].like!,
                            userId: posts[index].userId.toString(),
                            uniqueIdOfPost: posts[index].postId!,
                            time: posts[index].time!,
                            caption: posts[index].caption!,
                          ),
                        );
                      },
                    ),
                  );
                }
                      },
                    ),
              ),
            ],
          )),
    );
  }
}

