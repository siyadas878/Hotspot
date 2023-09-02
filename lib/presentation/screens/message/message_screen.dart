import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/back_arrow.dart';
import '../../../applications/provider/message_provider/list_messages_users.dart';
import '../../../domain/user_model/user_model.dart';
import '../chat_screen/chat_screen.dart';
import '../meassage_search_screen/message_search.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MessageSearchScreen()),
            );
          },
          icon: const Icon(FontAwesomeIcons.magnifyingGlass),
        ),
        title: 'Messages',
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: BackArrow(
            size: size,
            backFunction: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
  child: FutureBuilder<List<UserModel>>(
    future: ListMessagedUsers().getMessagedUsers(),
    builder: (context, snapshot) {
       if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData ) {
        return const Center(child: Text('No chat'));
      }
      return ListView.separated(
        padding: const EdgeInsets.only(top: 15),
        separatorBuilder: (context, index) => SizedBox(
          height: size.height * 0.02,
        ),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final user = snapshot.data![index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    fromId: user.uid.toString(),
                    title: user.name!,
                    imageUrl: user.imgpath!,
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.imgpath.toString()),
            ),
            title: Text(
              user.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('data'),
          );
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
