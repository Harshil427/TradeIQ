// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text('Charts'),
      ),
    );
  }
}
