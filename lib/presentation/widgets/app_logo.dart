import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String? head;
  const AppLogo({
    Key? key,
    this.head,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      head.toString(),
      style: GoogleFonts.jollyLodger(
        fontSize: size,
      ),
    );
  }
}
