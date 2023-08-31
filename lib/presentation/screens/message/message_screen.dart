import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/presentation/screens/meassage_search_screen/message_search.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/back_arrow.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(
          trailing: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const MessageSearchScreen(),));
              }, icon: const Icon(FontAwesomeIcons.magnifyingGlass)),
          title: 'Messages',
          leading: Padding(
            padding: const EdgeInsets.all(6),
            child: BackArrow(
              size: size,
              backFunction: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: 5, 
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(radius: 30),
                      title: Text('Username'),
                      subtitle: Text('Name'),
                      trailing: IconButton(
                          onPressed: () {}, icon:const Icon(Icons.delete)),
                      onTap: () {
                        // Handle item tap
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
