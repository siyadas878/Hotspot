import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String collectionDbName = 'instagram_stories_db';
  CollectionReference dbInstance =
      FirebaseFirestore.instance.collection(collectionDbName);

  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _uploadStoryToFirebase(File imageFile) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('stories')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    await storageReference.putFile(imageFile).then((TaskSnapshot snapshot) {
      snapshot.ref.getDownloadURL().then((String downloadUrl) {
        dbInstance.add({
          'image_url': downloadUrl,
          'caption': _captionController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Clone"),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Handle messages button click
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200, // Adjust the height as needed
              child: FlutterInstagramStories(
                collectionDbName: collectionDbName,
                showTitleOnIcon: true,
                backFromStories: () {
                  _backFromStoriesAlert();
                },
                iconTextStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
                iconImageBorderRadius: BorderRadius.circular(15.0),
                iconBoxDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Color(0xFFffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff333333),
                      blurRadius: 10.0,
                      offset: Offset(
                        0.0,
                        4.0,
                      ),
                    ),
                  ],
                ),
                iconWidth: 150.0,
                iconHeight: 150.0,
                textInIconPadding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
                // ... Your existing configuration ...
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "App's functionality",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
  onPressed: () async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery); // You can use ImageSource.camera for the camera.
    
    if (pickedImage != null) {
      // Upload the picked image to Firebase
      await _uploadStoryToFirebase(File(pickedImage.path));

      // Optionally, clear the caption field
      _captionController.clear();

      // Reload the stories to display the new one
      setState(() {});
    }
  },
  child: Text('Add Story'),
),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'Enter caption (optional)',
                ),
              ),
            ),
            // Add other content below the stories
          ],
        ),
      ),
    );
  }

  _backFromStoriesAlert() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text(
          "User have looked stories and closed them.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: const Text("Dismiss"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
