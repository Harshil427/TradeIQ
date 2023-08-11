// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, file_names, sort_child_properties_last, unused_import, unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import '../API/api.dart';
import '../Demo/DemoCandle.dart';
import '../Screens/Tools/RecommendationChart.dart';
import '../Screens/Tools/TradingViewChart.dart';

class StockProfileScreen extends StatefulWidget {
  final stock;
  const StockProfileScreen({
    super.key,
    required this.stock,
  });

  @override
  State<StockProfileScreen> createState() => _StockProfileScreenState();
}

class _StockProfileScreenState extends State<StockProfileScreen> {
  Map<String, dynamic> companyData = {};
  Map<String, dynamic> stockQuoteData = {};
  var recommendationData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchCompanyData();
    _fetchStockQuoteData();
    _fetchRecommendationStock();

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      _fetchStockQuoteData();
      _fetchRecommendationStock();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (companyData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildStockInfoContainer(width),
            Divider(),
            buildDetailsAboutCompany(),
            Divider(),
            buildAnimationAreaDefault(
              width,
            ),
            Divider(),
            RecommendationChart(recommendationData),
            Divider(),
            buildStockDataContainer(),
            // Divider(),
            buildAboutMoreStockContainer(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        widget.stock['description'],
      ),
    );
  }

  buildAnimationAreaDefault(double width) {
    return SizedBox(
      height: 328,
      width: width * 0.9,
      // child: Center(
      //   child: Text('Work Pending'),
      // ),
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.miniChartWidget('NASDAQ:AAPL'),
      ),
    );
  }

  buildStockDataContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Stock Data\n",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  'Market Capitalization: \$${(1415993 / 1000000).toStringAsFixed(2)}M\n',
              style: TextStyle(
                color: Colors.grey[100],
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: "Exchange: ${companyData['exchange']}\n",
              style: TextStyle(
                color: Colors.grey[100],
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: '${showIPOPrice()}',
              style: TextStyle(
                color: Colors.grey[100],
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
            ),
            TextSpan(
              text:
                  'Share Outstanding: ${companyData['shareOutstanding'].toStringAsFixed(2)} shares',
              style: TextStyle(
                color: Colors.grey[100],
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildStockPriceContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 100,
      decoration: buildContainerDecoration(),
      child: buildStockPriceRow(),
    );
  }

  buildStockPriceRow() {
    return Row(
      children: [
        SizedBox(width: 10),
        buildStockAvatar(),
        SizedBox(width: 20),
        buildCompanyDetailsColumn(),
      ],
    );
  }

  buildAboutMoreStockContainer() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }

  buildStockInfoContainer(double width) {
    return SizedBox(
      width: width * 0.9,
      height: 150,
      child: TradingViewWidgetHtml(
        widget:
            TradingViewServices.singleTickerWidget('${widget.stock['symbol']}'),
      ),
    );
    // return Container(
    //   margin: EdgeInsets.all(20),
    //   height: 100,
    //   decoration: buildContainerDecoration(),
    //   child: Row(
    //     children: [
    //       SizedBox(width: 10),
    //       buildStockAvatar(),
    //       SizedBox(width: 20),
    //       buildCompanyDetailsColumn(),
    //       Spacer(),
    //       buildStockPriceText(),
    //       SizedBox(width: 10),
    //     ],
    //   ),
    // );
  }

  buildDetailsAboutCompany() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "High: ${stockQuoteData['h']}",
            style: TextStyle(
              color: Color.fromARGB(255, 43, 255, 0),
              fontSize: 14,
            ),
          ),
          Text(
            "Open: ${stockQuoteData['o']}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Text(
            "Low: ${stockQuoteData['l']}",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 0, 0),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  buildStockPriceText() {
    if (stockQuoteData.isNotEmpty) {
      bool isLowOrNot =
          stockQuoteData['o'] < stockQuoteData['c'] ? true : false;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\$ ${stockQuoteData['c']}",
            style: TextStyle(
              color: isLowOrNot ? Color.fromARGB(255, 47, 255, 0) : Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Center(
          // child: LinearProgressIndicator(),
          );
    }
  }

  ShapeDecoration buildContainerDecoration() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, -1.00),
        end: Alignment(0, 1),
        colors: [
          Color.fromARGB(255, 0, 255, 183),
          Color.fromARGB(221, 3, 200, 255),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  CircleAvatar buildStockAvatar() {
    if (companyData['logo'] != null) {
      return CircleAvatar(
        child: SvgPicture.network(companyData['logo']),
        radius: 25,
      );
    } else {
      // Return a placeholder or alternative content if data is not available
      return CircleAvatar(
        radius: 30,
        child: Icon(Icons.image), // Placeholder icon
      );
    }
  }

  Column buildCompanyDetailsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          companyData['ticker'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> _fetchCompanyData() async {
    try {
      final data = await API().getStockProfile(widget.stock['symbol']);
      setState(() {
        companyData = data;
      });
      print(companyData);
    } catch (error) {
      print("Error fetching company data: $error");
    }
  }

  Future<void> _fetchStockQuoteData() async {
    try {
      final data = await API().fetchStockQuoteData(widget.stock['symbol']);
      setState(() {
        stockQuoteData = data;
      });
      print(stockQuoteData);
    } catch (error) {
      print("Error fetching stock quote data: $error");
    }
  }

  Future<void> _fetchRecommendationStock() async {
    try {
      final data = await API().getRecommendationData(widget.stock['symbol']);
      setState(() {
        recommendationData = data;
      });
      print(recommendationData);
    } catch (error) {
      print("Error fetching stock recommendation data: $error");
    }
  }

  showIPOPrice() {
    String ipoDateString = '${companyData['ipo']}';
    DateTime ipoDate = DateTime.parse(ipoDateString);
    String formattedIPODate = DateFormat('MMMM dd, yyyy').format(ipoDate);

    return 'IPO Date: $formattedIPODate';
  }
}
