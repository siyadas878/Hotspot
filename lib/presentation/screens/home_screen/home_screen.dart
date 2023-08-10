import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/drawer_screen/drawer.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';

import '../message/message_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: DrawerScreen(),
      appBar: MyAppBar(
          title: 'Hotspot',
          trailing: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(),));
              },
              icon:
                const  Icon(FontAwesomeIcons.facebookMessenger, color: tealColor))),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return PostWidget(size: size);
              },
              separatorBuilder: (context, index) => const Padding(
                padding:  EdgeInsets.only(left: 20),
                child: Text('time'),
              ),
              itemCount: 10)),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 220, 217, 217),
            borderRadius: BorderRadius.circular(15)),
        height: size.height * 0.27,
        child: Column(
          children: [
            Container(
              height: size.height*0.20,
              decoration:const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg'),
                      fit: BoxFit.cover)),
            ),
            
            ListTile(
              leading: CircleAvatar(),
              title: Text('Ziyad'),
              trailing: Row(mainAxisSize: MainAxisSize.min,
                children: [Icon(FontAwesomeIcons.heart),
                SizedBox(width: size.width*0.05),
                Icon(FontAwesomeIcons.message)],),
            )
          ],
        ),
      ),
    );
  }
}
