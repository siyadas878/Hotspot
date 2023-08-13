import 'package:flutter/material.dart';

import '../../core/constants/consts.dart';

class FollowIcon extends StatelessWidget {
  const FollowIcon({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.12,
      height: size.height * 0.03,
      decoration: BoxDecoration(
          color: tealColor, borderRadius: BorderRadius.circular(30)),
      child: const Center(
          child: Text(
        'Follow',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
