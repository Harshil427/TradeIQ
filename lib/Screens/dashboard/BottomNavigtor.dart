// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:tradeiq/Screens/dashboard/Charts.dart';
import 'package:tradeiq/Screens/dashboard/HomeScreen.dart';
import 'package:tradeiq/Screens/dashboard/MarketScreen.dart';
import 'package:tradeiq/Screens/dashboard/ProfileScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../../Provider/Variable.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    // final myVariable = Provider.of<NavBarVisibility>(context);
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      navBarStyle: NavBarStyle.style1,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: const Color.fromARGB(255, 0, 0, 0),
      ),
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.elasticIn,
        duration: Duration(milliseconds: 200),
      ),
      // hideNavigationBar: !myVariable.isVisible,
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ChartsScreen(),
      MarketScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Color.fromARGB(255, 96, 157, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.auto_graph),
        title: "Charts",
        activeColorPrimary: Color.fromARGB(255, 96, 157, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.newspaper),
        title: "News",
        activeColorPrimary: Color.fromARGB(255, 96, 157, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Color.fromARGB(255, 96, 157, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
    ];
  }
}
