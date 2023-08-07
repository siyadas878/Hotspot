import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          leading: Icon(FontAwesomeIcons.bars, color: tealColor),
          title: 'Hotspot',
          trailing: IconButton(
              onPressed: () {},
              icon:
                  Icon(FontAwesomeIcons.facebookMessenger, color: tealColor))),
      backgroundColor: tealColor,
    );
  }
}
