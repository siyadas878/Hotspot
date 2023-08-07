import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hotspot',
      style: GoogleFonts.jollyLodger(
        fontSize: size,
      ),
    );
  }
}
