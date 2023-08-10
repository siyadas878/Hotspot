import 'package:flutter/material.dart';

import '../../../core/constants/consts.dart';
import '../../widgets/app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '   Notification'),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: tealColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: 5, // Update this with the actual number of items
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(radius: 30),
                        title: Row(
                          children: [
                            Text(
                              'Username,  ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('started following you'),
                          ],
                        ),
                      ),
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
