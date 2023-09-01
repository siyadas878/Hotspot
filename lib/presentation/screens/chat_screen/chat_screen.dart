import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/presentation/screens/chat_screen/widgets/message_field.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../applications/provider/message_provider/message_provider.dart';
import '../../../domain/message_model/message_model.dart';
import '../../widgets/app_logo.dart';

class ChatScreen extends StatelessWidget {
  final String fromId;
  final String title;
  final String imageUrl;

  const ChatScreen({Key? key, required this.fromId, required this.title,required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height*0.08,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
            SizedBox(width: size.width*0.02,),
            AppLogo(size: 30, head: title),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Consumer<MessageCreationProvider>(
                builder: (context, messageProvider, _) {
                  return FutureBuilder<List<MessageModel>>(
                    future: messageProvider.getAllMessages(fromId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text('No chats'));
                      }

                      final messages = snapshot.data!;

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: size.height * 0.02),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          DateTime postDateTime =
                              DateTime.parse(messages[index].time.toString());
                          bool isCurrentUser = messages[index].fromId == userId;

                          return Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? Colors.teal
                                      : Colors.teal[300],
                                  borderRadius: isCurrentUser
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                ),
                                child: Text(
                                  messages[index].message!,
                                  style: const TextStyle(color: Colors.white,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  timeago
                                      .format(postDateTime, allowFromNow: true)
                                      .toString(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.07,
                color: Colors.white,
                child: Row(
                  children: [
                   const Expanded(
                      child: MessageField(),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        context
                            .read<MessageCreationProvider>()
                            .addMessage(fromId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}