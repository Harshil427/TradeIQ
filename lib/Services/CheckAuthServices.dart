// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradeiq/Constants/Variable.dart';
import 'package:tradeiq/Screens/Auth/Login_screen.dart';
import 'package:tradeiq/Screens/Start/Intro.dart';
import 'package:tradeiq/Screens/dashboard/HomeScreen.dart';

class AuthWrapper extends StatelessWidget {
  Widget _getScreenBasedOnAuthStatus(User? user) {
    if (user != null) {
      return HomeScreen();
    } else {
      if (moveFromSignOut) {
        return LoginScreen();
      } else {
        return IntroScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return _getScreenBasedOnAuthStatus(snapshot.data);
        } else {
          return Scaffold(
            body: Center(
              child: const CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
