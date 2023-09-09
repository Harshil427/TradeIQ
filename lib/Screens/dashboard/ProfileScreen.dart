// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradeiq/Components/market_status.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Module/User.dart';
import 'package:tradeiq/Screens/Tools/Edit_ProfileScreen.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../Pages/EconomicCalendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: buildProfileBody(),
      ),
    );
  }

  PreferredSize buildAppBar() {
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

  Widget buildProfileBody() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildUserProfileSection(context),
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

  Widget buildUserSectionBody() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        bottom: 13,
      ),
      child: Column(
        children: [
          buildListTile(Icons.add_alarm_sharp, 'Alerts', () {}),
          buildListTile(
              Icons.align_horizontal_left_rounded, 'Predictions', () {}),
          buildListTile(Icons.push_pin, 'Saved elements', () {}),
          buildListTile(Icons.monetization_on_rounded, 'Portfolio', () {}),
          buildListTile(
            Icons.calendar_month_outlined,
            "Economic Calendar",
            () {
              moveNextPage(context, EconomicCalendarPage());
            },
          )
        ],
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildUserProfileSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            foregroundColor: Colors.white,
            backgroundImage: _userData != null &&
                    _userData!.profileImage != null &&
                    _userData!.profileImage!.isNotEmpty
                ? NetworkImage(
                    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
                  )
                : null,
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
                  moveNextPage(
                    context,
                    EditProfileScreen(),
                  );
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
          buildListTileWithImage(
              'Assets/Images/icons/profit.png', 'Select Stocks', () {}),
          buildListTileWithImage(
              'Assets/Images/icons/analysis.png', 'Analysis', () {}),
          buildListTileWithImage(
              'Assets/Images/icons/broker.png', 'Best Broker', () {}),
          GestureDetector(
            onTap: () {
              moveNextPage(context, MarketStatusWidget());
            },
            child: buildListTileWithImage(
                'Assets/Images/icons/institution.png', 'Market Status', () {
              moveNextPage(context, MarketStatusWidget());
            }),
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
          buildListTileWithImage(
              'Assets/Images/icons/help.png', 'Help Center', () {}),
          buildListTileWithImage(
              'Assets/Images/icons/service.png', 'Support', () {}),
          buildListTileWithImage(
              'Assets/Images/icons/bug.png', 'Report Bug', () {}),
        ],
      ),
    );
  }

  Widget buildSignOutSection() {
    return Padding(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        children: [
          buildListTile(Icons.logout_sharp,
              'Sign Out\n${_userData != null ? _userData!.email : 'Loding data...'}',
              () {
            AuthServices().signOut();
          }),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildListTileWithImage(
      String imagePath, String title, VoidCallback? onTap) {
    return ListTile(
      leading: SizedBox(
        width: 30,
        height: 30,
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
      title: Opacity(
        opacity: 0.68,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
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
