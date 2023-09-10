import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/post_provider/follow_provider.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/user_screen/user_screen.dart';
import 'package:hotspot/presentation/widgets/shimmer_list.dart';
import 'package:provider/provider.dart';
import 'package:hotspot/applications/provider/search_provider/search_provider.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import '../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../domain/user_model/user_model.dart';
import '../../widgets/follow_icon.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<GetallUsersProvider>(context).searchController;

    return Scaffold(
      appBar: const MyAppBar(title: 'Search'),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ChangeNotifierProvider<GetallUsersProvider>.value(
                value: Provider.of<GetallUsersProvider>(context, listen: false),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    Provider.of<GetallUsersProvider>(context, listen: false)
                        .searchlist(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        Provider.of<GetallUsersProvider>(context, listen: false)
                            .searchlist('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<GetallUsersProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<void>(
                    future: value.getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ShimmerList();
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      } else {
                        final userList = controller.text.isEmpty
                            ? value.allusers
                            : value.searchedlist;

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
                              subtitle: Text(user.name!,style:const TextStyle(color: Colors.grey),),
                              trailing: Consumer<FollowProvider>(
                                builder: (context, value, child) {
                                  String userId = FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString();
                                  String otherUserId =
                                      userList[index].uid.toString();
                                  return InkWell(
                                    onTap: () {
                                      Provider.of<FollowProvider>(context,listen: false).followfollowing(userId, otherUserId);
                                    },
                                    child: FutureBuilder<UserModel?>(
                                      future: GetProfileData().getUserData(FirebaseAuth.instance.currentUser!.uid),
                                      builder: (context, iconsnapshot) {
                                        if (iconsnapshot.connectionState==ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        return FollowIcon(
                                        size: size,
                                        name: iconsnapshot.data!.following!.contains(user.uid)
                                            ? 'Following'
                                            : 'Follow',
                                        color: Colors.white,
                                        backgroundcolor: tealColor,
                                      );
                                      },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
