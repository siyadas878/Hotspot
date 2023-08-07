import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/add_screen.dart';
import 'package:hotspot/presentation/screens/home_screen.dart';
import 'package:hotspot/presentation/screens/notification_screen.dart';
import 'package:hotspot/presentation/screens/profile_screen.dart';
import 'package:hotspot/presentation/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../application/provider/nav_state.dart';

class NavScreen extends StatelessWidget {
  NavScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavBAr>(
      create: (context) => NavBAr(),
      child: Scaffold(
        body: Consumer<NavBAr>(
          builder: (context, navcontroller, child) {
            return _screens[navcontroller.currentIndex];
          },
        ),
        bottomNavigationBar: Consumer<NavBAr>(
          builder: (context, navcontroller, child) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.magnifyingGlass),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.squarePlus),
                  label: 'add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.circleExclamation),
                  label: 'notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                  label: 'profile',
                ),
              ],
              unselectedItemColor: Colors.grey,
              selectedItemColor: tealColor,
              currentIndex: navcontroller.currentIndex,
              onTap: (index) => navcontroller.onNavIndex(index),
            );
          },
        ),
      ),
    );
  }
}