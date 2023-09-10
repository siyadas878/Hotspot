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
    const SearchScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddScreen(),
            ),
          );
        },
        backgroundColor: tealColor,
        child:const Icon(FontAwesomeIcons.squarePlus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<NavBAr>(
        builder: (context, navcontroller, child) {
          return BottomAppBar(
            shape:const CircularNotchedRectangle(),
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon:const Icon(FontAwesomeIcons.house),
                  color: navcontroller.currentIndex==0?tealColor:Colors.grey,
                  onPressed: () => navcontroller.onNavIndex(0),
                ),
                IconButton(
                  icon:const Icon(FontAwesomeIcons.magnifyingGlass),
                  color: navcontroller.currentIndex==1?tealColor:Colors.grey,
                  onPressed: () => navcontroller.onNavIndex(1),
                ),
                const SizedBox(), 
                IconButton(
                  icon:const Icon(FontAwesomeIcons.bell),
                  color: navcontroller.currentIndex==2?tealColor:Colors.grey,
                  onPressed: () => navcontroller.onNavIndex(2),
                ),
                IconButton(
                  icon:const Icon(FontAwesomeIcons.user),
                  color: navcontroller.currentIndex==3?tealColor:Colors.grey,
                  onPressed: () => navcontroller.onNavIndex(3),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
