// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unnecessary_string_interpolations

// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Module/User.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
// import 'package:tradeiq/Constants/Variable.dart';

import '../../Constants/Variable.dart';
// import '../../Provider/Variable.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// bool _isVisible = true;
  // double _scrollPosition = 0.0;
  // late ScrollController _scrollController;
  // late Timer _hideTimer;

  User? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    String uid = AuthServices().getUid();
    User? userData = await DatabaseServices().fetchUserData(uid);
    setState(() {
      _userData = userData;
    });
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_handleScroll);
    // _scrollController.dispose();
    // _hideTimer.cancel();
    super.dispose();
  }

  // void _handleScroll() {
  //   final navBarVisibility = Provider.of<NavBarVisibility>(
  //     context,
  //     listen: false,
  //   );

  //   if (_scrollController.position.userScrollDirection ==
  //       ScrollDirection.forward) {
  //     navBarVisibility.setVisible(true);
  //   } else if (_scrollController.position.userScrollDirection ==
  //       ScrollDirection.reverse) {
  //     navBarVisibility.setVisible(false);
  //   }

  //   if (navBarVisibility.isVisible ||
  //       _scrollController.position.pixels <= _scrollPosition) {
  //     // Reset the timer and show the navigation bar immediately
  //     _hideTimer.cancel();
  //     navBarVisibility.setVisible(true);
  //   } else {
  //     // Start the timer to wait for 5 seconds before hiding the navigation bar
  //     _hideTimer.cancel();
  //     _hideTimer = Timer(const Duration(seconds: 5), () {
  //       navBarVisibility.setVisible(false);
  //     });
  //   }

  //   // Update the scroll position for next comparison
  //   _scrollPosition = _scrollController.position.pixels;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: buildProfileBody(),
      ),
    );
  }

  buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'MENU',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              'Assets/SVG/Icon/TopOnApp.svg',
              height: 40.0,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }

  buildUserSectionBody() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        bottom: 13,
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.add_alarm_sharp,
            ),
            title: Text(
              'Alerts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.align_horizontal_left_rounded,
            ),
            title: Text(
              'Predictions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.push_pin,
            ),
            title: Text(
              'Saved elements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on_rounded,
            ),
            title: Text(
              'Portfolio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileBody() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
        ),
      ),
      child: SingleChildScrollView(
        // controller: _scrollController,
        child: Column(
          children: [
            buildUserProfileSection(),
            Divider(),
            buildUserSectionBody(),
            Divider(),
            buildToolsSection(),
            Divider(),
            buildSupportSection(),
            Divider(),
            SizedBox(
              height: 20,
            ),
            buildSignOutSection(),
          ],
        ),
      ),
    );
  }

  Widget buildUserProfileSection() {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            foregroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          Text(
            _userData != null ? '${_userData!.name}' : 'Loading user data...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: width * .1),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Add your Setting button logic here
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white54,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add your Edit button logic here
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildToolsSection() {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 40, bottom: 13),
      child: Column(
        children: [
          SizedBox(height: height * .01),
          buildSectionTitle('Tools'),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/profit.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Select Stocks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/analysis.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/broker.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Best Broker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildSupportSection() {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 40, bottom: 13),
      child: Column(
        children: [
          SizedBox(height: height * .01),
          buildSectionTitle('Support'),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/help.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Help Center',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/service.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('Assets/Images/icons/bug.png'),
              ),
            ),
            title: Opacity(
              opacity: 0.68,
              child: Text(
                'Report bug',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildSignOutSection() {
    return Padding(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.logout_sharp,
              color: Colors.red,
            ),
            title: Opacity(
              opacity: 0.5,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sign Out',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: _userData != null
                          ? '${_userData!.email}'
                          : 'Loding data...',
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              AuthServices().signOut();
              setState(() {
                moveFromSignOut = true;
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          SvgPicture.asset('Assets/SVG/Icon/round.svg', width: 80),
          Text(
            '  $title',
            style: TextStyle(
              color: Color(0xFF151515),
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
