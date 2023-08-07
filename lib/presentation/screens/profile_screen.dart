import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';
import '../../core/constants/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
          title: 'Profile',
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bars, color: tealColor)),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.userPen, color: tealColor))),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.43,
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
                    borderRadius: const BorderRadius.all(Radius.circular(75)),
                    border: Border.all(
                      color: Colors.white, // Set your desired border color here
                      width: 7.0, // Set the width of the border
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage:
                          NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                    ),
                  ),
                ),
                SpaceWithHeight(size: size),
                const Text(
                  'Ziyad As',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
                SpaceWithHeight(size: size),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildNumberContainer(1, 'Followers',context),
                    SizedBox(width: size.width*0.03),
                    buildNumberContainer(2, 'Posts',context),
                    SizedBox(width: size.width*0.03),
                    buildNumberContainer(3, 'Following',context),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

Container buildNumberContainer(int number,String title, BuildContext context) {
  var size = MediaQuery.of(context).size;

  return Container(
    width: size.width * 0.18,
    height: size.height * 0.09,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white, // Set your desired border color here
        width: 2.0, // Set the width of the border
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(fontSize: 12,color: Colors.white),
            ),
            Text(
              '$number',
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
