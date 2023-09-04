// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import '../../Module/User.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('TradeIQ'),
        centerTitle: true,
      ),
      body: buildTestWidget(heigth, width),
    );
  }

  buildTestWidget(double height, double width) {
    return SizedBox(
      height: height * 0.4,
      width: width,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.economicCalendarWidget(),
      ),
    );
  }

  buildTempBody() {
    return Center(
      child: _userData != null
          ? Text('Welcome, ${_userData!.name}!')
          : Text('Loading user data...'),
    );
  }
}
