import 'package:flutter/material.dart';

class SpaceWithHeight extends StatelessWidget {
  const SpaceWithHeight({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size.height * 0.03);
  }
}
