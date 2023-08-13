import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';

import '../../widgets/follow_icon.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(title: '    Search'),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // Handle search logic here
                },
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search, color: tealColor),
                  suffixIcon: Icon(Icons.clear, color: tealColor),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: 5, // Update this with the actual number of items
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(radius: 30),
                      title: Text('Username'),
                      subtitle: Text('Name'),
                      trailing: FollowIcon(size: size),
                      onTap: () {
                        // Handle item tap
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
