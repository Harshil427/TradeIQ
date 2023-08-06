// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradeiq/Constants/Colors.dart';

import '../../Components/News_Page.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: backgroundColor,
      body: Center(
        child: buildNewsBody(context),
      ),
    );
  }

  buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'NEWS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Raleway',
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
}

Widget buildNewsBody(BuildContext context) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.all(5.0), // Add padding
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
        ),
      ),
      child: SingleChildScrollView(
        child: NewsPage(),
      ),
    ),
  );
}
