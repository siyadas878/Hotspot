import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';
import 'package:hotspot/presentation/widgets/space_with_height.dart';

import '../../../core/constants/consts.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(title: '    Add Post'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.7,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: tealColor, width: 2), // Adding border
                ),
                child: const Icon(
                  FontAwesomeIcons.image,
                  size: 50,
                ),
              ),
              SpaceWithHeight(size: size),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                    ),
                    child: const Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                    ),
                    child: const Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SpaceWithHeight(size: size),
              Container(
                width: size.width * 0.7,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(color: tealColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  style: const TextStyle(color: tealColor),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    labelText: 'Caption',
                    hintText: 'Caption',
                    labelStyle: TextStyle(color: tealColor, fontSize: 14),
                    hintStyle: TextStyle(color: tealColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SpaceWithHeight(size: size),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor,
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
