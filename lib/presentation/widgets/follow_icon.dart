import 'package:flutter/material.dart';

class FollowIcon extends StatelessWidget {
  const FollowIcon(
      {super.key,
      required this.size,
      required this.name,
      required this.color,
      required this.backgroundcolor});

  final Size size;
  final String name;
  final Color color;
  final Color backgroundcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.17,
      height: size.height * 0.03,
      decoration: BoxDecoration(
          color: backgroundcolor, borderRadius: BorderRadius.circular(30)),
      child: Center(
          child: Text(
        name,
        style: TextStyle(color: color,fontSize: 10),
      )),
    );
  }
}
