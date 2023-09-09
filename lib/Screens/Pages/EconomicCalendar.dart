// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../Constants/Colors.dart';
import '../../Services/TradingViewServices.dart';
import '../Tools/TradingViewChart.dart';

class EconomicCalendarPage extends StatefulWidget {
  const EconomicCalendarPage({super.key});

  @override
  State<EconomicCalendarPage> createState() => _EconomicCalendarPageState();
}

class _EconomicCalendarPageState extends State<EconomicCalendarPage> {
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        backgroundColor: backgroundColor,
        title: const Text('Calendar 📆'),
        // centerTitle: true,
      ),
      body: buildTestWidget(heigth, width),
    );
  }

  buildTestWidget(double height, double width) {
    return SizedBox(
      height: height * 0.88,
      width: width,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.economicCalendarWidget(),
      ),
    );
  }
}
