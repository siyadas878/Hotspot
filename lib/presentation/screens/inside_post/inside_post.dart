import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/applications/provider/get_data_in_profile.dart';
import 'package:hotspot/domain/user_model/user_model.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';

class InsidePost extends StatelessWidget {
  final String imageUrl;
  final String userId;
  const InsidePost({super.key, required this.imageUrl, required this.userId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(title: ''),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 220, 217, 217),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FutureBuilder<UserModel?>(
                    future: GetProfileData().getUserData(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('User not found'));
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data!.imgpath.toString()),
                        ),
                        title: Text(snapshot.data!.username!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(FontAwesomeIcons.heart),
                            SizedBox(width: size.width * 0.05),
                            const Icon(FontAwesomeIcons.message),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    height: size.height * 0.42,
                    color: Colors.white,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return  SizedBox(
                            height: size.height*0.1,
                            child: const Card(
                              child:  Center(
                                child: ListTile(
                                  title: Text('coment'),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.teal,
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration:const BoxDecoration(
                      color: Colors.white,
                    ),
                    // color: Color(0xFFFFFFFF),
                    child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  TextField(
                        maxLines: 3, // Adjust as needed
                        decoration: InputDecoration(
                          hintText: 'Write your comment...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
