// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        child: InteractiveViewer(
          child: Column(
            children: [
              // _buildTickerTapeWidget(),
              // _buildMarketOverviewWidget(),
              _buildMarketCapSection(),
              _buildTextOfForex(),
              _buildForexCrossRatesWidget(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTickerTapeWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width,
        height: 50, // Adjusted height for larger appearance
        child: TradingViewWidgetHtml(
          widget: TradingViewServices.tickerTapeWidget(),
        ),
      ),
    );
  }

  Widget _buildMarketOverviewWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      width: width,
      height: height * 0.5, // Adjusted height for larger appearance
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.marketOverviewWidget(),
      ),
    );
  }

  Widget _buildMarketCapSection() {
    return Column(
      children: [
        Text(
          'Market Cap by',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.all(10),
          width: width,
          height: height * 0.7, // Adjusted height for larger appearance
          child: TradingViewWidgetHtml(
            widget: TradingViewServices.stockHeatmapWidget(),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTextOfForex() {
    return Column(
      children: [
        Text(
          'Forex Cross Rates',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildForexCrossRatesWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      width: width,
      height: height * 0.5, // Adjusted height for larger appearance
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.forexCrossRatesWidget(),
      ),
    );
  }
}
