import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotspot/core/constants/consts.dart';
import 'package:hotspot/presentation/screens/add_screen/add_screen.dart';
import 'package:hotspot/presentation/screens/home_screen/home_screen.dart';
import 'package:hotspot/presentation/screens/notification_screen/notification_screen.dart';
import 'package:hotspot/presentation/screens/profile_screen/profile_screen.dart';
import 'package:hotspot/presentation/screens/search_screen/search_screen.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider/navbar_provider/nav_state.dart';

class NavScreen extends StatelessWidget {
  NavScreen({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    SearchScreen(),
    AddScreen(),
    const NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(FontAwesomeIcons.bell),
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
    );
  }
}
