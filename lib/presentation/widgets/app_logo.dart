import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../applications/provider/theme_provider/theme_provider.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String? head;
  final Color color;
  const AppLogo({
    Key? key,
    this.head,
    required this.size,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      head.toString(),
      style: GoogleFonts.jollyLodger(
        fontSize: size,color: context.read<ThemeProvider>().isDarkMode?Colors.grey:Colors.black
      ),
    );
  }
}
