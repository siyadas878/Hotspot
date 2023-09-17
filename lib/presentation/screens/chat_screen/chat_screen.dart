import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/presentation/screens/chat_screen/widgets/message_field.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../applications/provider/message_provider/message_provider.dart';
import '../../../core/constants/consts.dart';
import '../../../domain/message_model/message_model.dart';
import '../../../infrastructure/push_notification.dart';

class ChatScreen extends StatelessWidget {
  final String fromId;
  final String title;
  final String imageUrl;
  final String? fcmTocken;
  const ChatScreen(
      {Key? key,
      required this.fromId,
      required this.title,
      required this.imageUrl,
      this.fcmTocken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.08,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
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

                      DateTime? previousMessageDate;

                      return ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          DateTime postDateTime =
                              DateTime.parse(messages[index].time.toString());
                          bool isCurrentUser = messages[index].fromId == userId;

                          bool showDate = previousMessageDate == null ||
                              previousMessageDate!.day != postDateTime.day ||
                              previousMessageDate!.month !=
                                  postDateTime.month ||
                              previousMessageDate!.year != postDateTime.year;

                          previousMessageDate = postDateTime;

                          return Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              if (showDate)
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "${postDateTime.day}/${postDateTime.month}/${postDateTime.year}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color:tealColor,
                                      ),
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onLongPress: () {
                                  if (messages[index].userId == userId) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete'),
                                        content:
                                            const Text('Do yo want to delete'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('CANCEL',
                                                style: TextStyle(
                                                    color: tealColor)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'DELETE',
                                              style:
                                                  TextStyle(color: tealColor),
                                            ),
                                            onPressed: () async {
                                              context
                                                  .read<
                                                      MessageCreationProvider>()
                                                  .deleteMessage(
                                                      fromId,
                                                      snapshot
                                                          .data![index].id!);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Container(
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
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  timeago
                                      .format(postDateTime, allowFromNow: true)
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
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
              child: SizedBox(
                height: size.height * 0.07,
                child: Row(
                  children: [
                    const Expanded(
                      child: MessageField(),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () async{
                        if (context
                            .read<MessageCreationProvider>()
                            .messageController
                            .text
                            .isEmpty) {
                          Null;
                        } else {
                          context
                              .read<MessageCreationProvider>()
                              .addMessage(fromId);

                        await  LocalNotificationService.sendNotification(
                              title: "New message",
                              message: context
                                  .read<MessageCreationProvider>()
                                  .messageController
                                  .text,
                              token: fcmTocken);
                        }
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
