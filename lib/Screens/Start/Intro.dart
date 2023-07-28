// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Utils/Functions.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController();
  bool onLast = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              _pageController.jumpToPage(
                2,
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFFE5E5E5),
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            child: onLast ? Text('') : Text('Skip'),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              onLast = (value == 2);
            });
          },
          controller: _pageController,
          children: [
            introPage1(height, width),
            introPage2(height, width),
            introPage3(height, width),
          ],
        ),
      ),
      bottomNavigationBar: onboardingScreenBottom(
        _pageController,
        onLast,
        height,
        3,
      ),
    );
  }

  Widget introPage1(double height, double width) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            image: AssetImage(
              'Assets/Images/UI/Intro/1.png',
            ),
            // height: height * 0.4,
            // width: width * 0.8,
          ),
          SizedBox(
            width: width * 0.7,
            // height: 90,
            child: Text(
              'Start to invest for your future!',
              style: TextStyle(
                color: Color(0xFFF4F4F4),
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }

  introPage2(double height, double width) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 295,
            // height: 68,
            child: Text(
              'Follow our tipsto achieve success!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Image(
            image: AssetImage(
              'Assets/Images/UI/Intro/2.png',
            ),
            // height: height * 0.4,
            // width: width * 0.8,
          ),
        ],
      ),
    );
  }

  introPage3(double height, double width) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            image: AssetImage(
              'Assets/Images/UI/Intro/3.png',
            ),
            // height: height * 0.5,
            // width: width * 0.8,
          ),
          SizedBox(
            height: height * 0.08,
          ),
          SizedBox(
            width: 268,
            // height: 63,
            child: Text(
              'Keep your investment safe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
