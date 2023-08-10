import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/get_data_in_profile.dart';
import 'package:hotspot/presentation/screens/drawer_screen/drawer.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import 'package:hotspot/domain/models/user_model/user_model.dart';
import '../../../core/constants/consts.dart';


// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

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
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.userPen, color: tealColor),
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
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage:
                                NetworkImage(user.imgpath.toString()),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildNumberContainer(
                            5,
                            'Followers',
                            context,
                          ),
                          SizedBox(width: size.width * 0.03),
                          buildNumberContainer(
                            10,
                            'Posts',
                            context,
                          ),
                          SizedBox(width: size.width * 0.03),
                          buildNumberContainer(
                            3,
                            'Following',
                            context,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                  child: GridView.builder(
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      mainAxisSpacing: 10.0, 
                      crossAxisSpacing: 10.0, 
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image:const DecorationImage(image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe5OCMSr-h-OeQkxRfSdURLG7WGzv0X4rHUw&usqp=CAU'),
                            fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                          color: tealColor
                        ),
                      );
                    },
                    itemCount: 10,
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

buildNumberContainer(int number, String title, BuildContext context) {
  var size = MediaQuery.of(context).size;

  return Container(
    width: size.width * 0.18,
    height: size.height * 0.09,
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
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              number.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
