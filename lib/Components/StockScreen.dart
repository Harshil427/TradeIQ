// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    super.key,
  });

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width,
                height: 50,
                child: TradingViewWidgetHtml(
                  widget: TradingViewServices.tickerTapeWidget(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: width,
              height: heigth * 0.6,
              child: TradingViewWidgetHtml(
                widget: TradingViewServices.marketOverviewWidget(),
              ),
            ),
            Text(
              'Market Cap by',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: width,
              height: heigth * 0.5,
              child: TradingViewWidgetHtml(
                widget: TradingViewServices.stockHeatmapWidget(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: width,
              height: heigth * 0.3,
              child: TradingViewWidgetHtml(
                widget: TradingViewServices.forexCrossRatesWidget(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
