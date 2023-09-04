// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

import '../Screens/Tools/TradingViewChart.dart';
import '../Services/TradingViewServices.dart';

class TradingViewChart extends StatefulWidget {
  final stock;

  const TradingViewChart({Key? key, required this.stock}) : super(key: key);

  @override
  _TradingViewChartState createState() => _TradingViewChartState();
}

class _TradingViewChartState extends State<TradingViewChart> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: _buildTradingViewWidget(height, width),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text('${widget.stock['symbol']}'),
    );
  }

  Widget _buildTradingViewWidget(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: TradingViewWidgetHtml(
        widget:
            TradingViewServices.realTimeChart(widget.stock['symbol'], false),
      ),
    );
  }
}
