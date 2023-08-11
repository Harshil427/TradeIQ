// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

import '../Screens/Tools/TradingViewChart.dart';
import '../Services/TradingViewServices.dart';

class TradingViewChart extends StatefulWidget {
  final stock;
  const TradingViewChart({super.key, this.stock});

  @override
  State<TradingViewChart> createState() => _TradingViewChartState();
}

class _TradingViewChartState extends State<TradingViewChart> {
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('${widget.stock['symbol']}'),
      ),
      body: SizedBox(
        height: heigth,
        width: width,
        child: TradingViewWidgetHtml(
          widget: TradingViewServices.realTimeChart(
            widget.stock['symbol'],
          ),
        ),
      ),
    );
  }
}
