// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeiq/Constants/Variable.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/CheckAuthServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              setState(() {
                moveFromSignOut = true;
              });
              Future<String> res = AuthServices().signOut();

              res.then((value) {
                if (value == 'Success') {
                  Get.offAll(
                    AuthWrapper(),
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
