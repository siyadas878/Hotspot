import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/core/constants/consts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;

  const MyAppBar(
      {super.key,
      required this.title,
      this.leading,
       this.trailing});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: AppBar(
        elevation: 20,

        title: Text(
          title,
          style: GoogleFonts.jollyLodger(fontSize: 30),
        ),
        leading: leading,
        actions: [if (trailing != null) trailing!],
      ),
    );
  }
}
