// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradeiq/Screens/Auth/Login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

Widget onboardingScreenBottom(
    PageController pageController, bool onLast, double height, int pageCount) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: height * 0.2,
          width: double.infinity,
          alignment: Alignment(-0.2, 0.5),
          child: SmoothPageIndicator(
            controller: pageController,
            count: pageCount,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: height * 0.2,
          width: double.infinity,
          alignment: Alignment(0.4, 0.5),
          child: ElevatedButton(
            onPressed: () {
              if (onLast) {
                Get.off(
                  LoginScreen(),
                  transition: Transition.leftToRight,
                );
              } else {
                pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
            },
            child: Text(
              onLast ? 'Get Started' : 'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shadowColor: Color.fromARGB(0, 209, 208, 208),
              foregroundColor: Color.fromARGB(55, 11, 240, 1),
              backgroundColor: Color.fromARGB(143, 189, 134, 206),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // padding: EdgeInsets.symmetric(
              //   vertical: 1,
              // ),
            ),
          ),
        ),
      ),
    ],
  );
}

moveNextPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

moveNextPagePop(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No image selected');
  return Uint8List(0);
}

launchURL(String u) async {
    final Uri url = Uri.parse(u);

    if (!await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      print('Could not launch $url');
    }
  }