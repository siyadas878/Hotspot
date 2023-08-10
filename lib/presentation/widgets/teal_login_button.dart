import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';

class TealLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  TealLoginButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tealColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corner radius
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
