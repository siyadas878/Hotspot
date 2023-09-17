import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../../applications/provider/story_provider/story_viewer.dart';


class StorieView extends StatefulWidget {
 const StorieView({
    super.key,
    required this.image,
  });
  final String image;

  @override
  State<StorieView> createState() => _StorieViewState();
}

class _StorieViewState extends State<StorieView> {
  double precent = 0.0;

  void startTime(StorieControllerProvider provider) {
    Timer.periodic(const Duration(milliseconds: 3), (timer) {
      setState(() {
        precent += 0.001;
        if (precent > 1) {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    final storieControllerProvider =
        Provider.of<StorieControllerProvider>(context, listen: false);
    startTime(storieControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.image)),
              ),
            ),
            LinearProgressIndicator(
              value: precent,
              backgroundColor: Colors.grey,
              valueColor:const AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
            Positioned(
                top: size.height * 0.02,
                right: size.width * 0.02,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: size.width * 0.08,
                  color: Colors.grey,
                  icon: const Icon(Icons.close),
                )),
          ],
        ),
      ),
    );
  }
}
