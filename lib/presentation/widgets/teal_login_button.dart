import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';

class TealLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  TealLoginButton({
    required this.onPressed,
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tealColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), 
        ),
      ),
      child:  isLoading
          ?const CircularProgressIndicator(color: Colors.white):Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
