import 'package:flutter/material.dart';

import '../../core/constants/consts.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
    required this.size,
    required this.backFunction, // Add the required function parameter
  });

  final Size size;
  final VoidCallback backFunction; // Define the function type

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: backFunction, // Use the passed function for the onTap event
      child: Container(
        decoration: const BoxDecoration(
          color: tealColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: size.height * 0.05,
        width: size.width * 0.1,
        // color: tealColor,
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
