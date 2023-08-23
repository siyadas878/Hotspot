import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotspot/applications/provider/search_provider/search_provider.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import '../../widgets/follow_icon.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<GetallUsersProvider>(context).searchController;
    var provider = Provider.of<GetallUsersProvider>(context, listen: false);

    provider.getAllUsers();

    return Scaffold(
      appBar: const MyAppBar(title: 'Search'),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ChangeNotifierProvider.value(
                value: provider,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    provider.searchlist(value);
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
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        provider.searchlist('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<GetallUsersProvider>(
                builder: (context, value, child) {
                  final userList = controller.text.isEmpty
                      ? value.allusers
                      : value.searchedlist;

                  if (userList.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.imgpath.toString()),
                        ),
                        title: Text(user.username!),
                        subtitle: Text(user.name!),
                        trailing: FollowIcon(size: size),
                        onTap: () {
                          // Handle item tap
                        },
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
