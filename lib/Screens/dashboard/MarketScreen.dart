// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text('Market'),
      ),
    );
  }
}
