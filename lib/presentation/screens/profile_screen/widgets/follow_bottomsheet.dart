import 'package:flutter/material.dart';
import 'package:hotspot/presentation/screens/user_screen/user_screen.dart';

import '../../../../applications/provider/profile_provider/get_data_in_profile.dart';
import '../../../../domain/user_model/user_model.dart';

void followersbottomSheet(BuildContext context, List<String> followers) {
  var size = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
          height: size.height * 0.5,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: followers.length,
            itemBuilder: (context, index) {
              String data = followers[index];
              return FutureBuilder<UserModel?>(
                future: GetProfileData().getUserData(data),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('User not found'));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.teal[100],
                      child: SizedBox(
                        height: size.height * 0.1,
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserScreen(uid: data)));
                            },
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(snapshot.data!.imgpath!),
                            ),
                            title: Text(snapshot.data!.name!),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ));
    },
  );
}
