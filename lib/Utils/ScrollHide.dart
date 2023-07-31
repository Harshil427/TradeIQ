// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tradeiq/Constants/Colors.dart';

import '../../Provider/Variable.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// bool _isVisible = true;
  double _scrollPosition = 0.0;
  late ScrollController _scrollController;
  late Timer _hideTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    _hideTimer = Timer(const Duration(seconds: 5), () {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _hideTimer.cancel();
    super.dispose();
  }

  void _handleScroll() {
    final navBarVisibility = Provider.of<NavBarVisibility>(
      context,
      listen: false,
    );

    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      navBarVisibility.setVisible(true);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      navBarVisibility.setVisible(false);
    }

    if (navBarVisibility.isVisible ||
        _scrollController.position.pixels <= _scrollPosition) {
      // Reset the timer and show the navigation bar immediately
      _hideTimer.cancel();
      navBarVisibility.setVisible(true);
    } else {
      // Start the timer to wait for 5 seconds before hiding the navigation bar
      _hideTimer.cancel();
      _hideTimer = Timer(const Duration(seconds: 5), () {
        navBarVisibility.setVisible(false);
      });
    }

    // Update the scroll position for next comparison
    _scrollPosition = _scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Text('Scroll Hide'),
        ),
      ),
    );
  }

}
