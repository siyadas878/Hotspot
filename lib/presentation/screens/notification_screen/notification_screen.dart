import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/notification_provider/notification_provider.dart';
import 'package:hotspot/applications/provider/profile_provider/get_data_in_profile.dart';
import 'package:hotspot/domain/notification_model/notification_model.dart';
import 'package:hotspot/domain/user_model/user_model.dart';
import '../../widgets/app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(title: 'Notification'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder<List<NotificationModel>>(
                  future: NotificationProvider().getAllNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Empty'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        DateTime postDateTime =
                            DateTime.parse(snapshot.data![index].time!);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: FutureBuilder<UserModel?>(
                            future: GetProfileData()
                                .getUserData(snapshot.data![index].fromId!),
                            builder: (context, profilesnapshot) {
                              if (profilesnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (!profilesnapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(child: Text('Empty'));
                              }
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      profilesnapshot.data!.imgpath!),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      '${profilesnapshot.data!.username},  ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].status!,
                                      style: const TextStyle(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  timeago
                                      .format(postDateTime, allowFromNow: true)
                                      .toString(),
                                      style: const TextStyle(color: Colors.grey,fontSize: 12)
                                ),
                              );
                            },
                          ),
                        );
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
