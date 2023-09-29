// ignore_for_file: file_names, prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, library_private_types_in_public_api, unnecessary_string_interpolations, sort_child_properties_last, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import '../API/api.dart';
// import '../Demo/DemoCandle.dart';
import '../Screens/Tools/RecommendationChart.dart';
import '../Screens/Tools/TradingViewChart.dart';
import 'TradingViewChart.dart';

class StockProfileScreen extends StatefulWidget {
  final stock;

  const StockProfileScreen({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  _StockProfileScreenState createState() => _StockProfileScreenState();
}

class _StockProfileScreenState extends State<StockProfileScreen> {
  Map<String, dynamic> companyData = {};
  Map<String, dynamic> stockQuoteData = {};
  var recommendationData = [];
  late Timer _timer;

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
    _timer.cancel();
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
      appBar: _buildAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStockInfoContainer(width),
            Divider(),
            // buildDetailsAboutCOH(),
            Divider(),
            _buildAnimationAreaDefault(width),
            Divider(),
            _buildFullChartButton(),
            Divider(),
            _buildStockDataContainer(),
            Divider(),
            _buildAboutMoreStockContainer(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        widget.stock['description'],
      ),
    );
  }

  Widget _buildStockInfoContainer(double width) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 100,
      decoration: _buildContainerDecoration(),
      child: Row(
        children: [
          SizedBox(width: 10),
          _buildStockAvatar(),
          SizedBox(width: 20),
          _buildCompanyDetailsColumn(),
          Spacer(),
          _buildStockPriceText(),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Container _buildStockDataContainer() {
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
              text: '${_showIPOPrice()}',
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

  Container _buildAboutMoreStockContainer() {
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
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildMoreOptionsRowCall(),
          SizedBox(height: 20),
          _buildRecommendationChart(),
        ],
      ),
    );
  }

  ElevatedButton _buildFullChartButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TradingViewChart(
              stock: widget.stock,
            ),
          ),
        );
      },
      child: Text('Show Full Chart'),
    );
  }

  SizedBox _buildAnimationAreaDefault(double width) {
    return SizedBox(
      height: 328,
      width: width * 0.9,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.miniChartWidget('NASDAQ:AAPL'),
      ),
    );
  }

  Row _buildCompanyDetailsColumn() {
    return Row(
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

  Widget _buildStockAvatar() {
    if (companyData['logo'] != null) {
      return CircleAvatar(
        child: SvgPicture.network(companyData['logo']),
        radius: 25,
      );
    } else {
      return CircleAvatar(
        radius: 30,
        child: Icon(Icons.image),
      );
    }
  }

  Column _buildMoreOptionsColumn(String s, Color c, int value) {
    return Column(
      children: [
        Text(
          s,
          style: TextStyle(
            color: c,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildMoreOptionsRow(Map<String, dynamic> data) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMoreOptionsColumn('Buy', Colors.green, data['buy']),
          _buildMoreOptionsColumn('Sell', Colors.red, data['sell']),
          _buildMoreOptionsColumn('Hold', Colors.blue, data['hold']),
        ],
      ),
    );
  }

  ListView _buildMoreOptionsRowCall() {
    return ListView.builder(
      itemCount: recommendationData.length,
      itemBuilder: (context, index) {
        return _buildMoreOptionsRow(recommendationData[index]);
      },
    );
  }

  Container _buildRecommendationChart() {
    return Container(
      height: 100,
      child: RecommendationChart(
        recommendationData,
      ),
    );
  }

  Text _buildStockPriceText() {
    if (stockQuoteData.isNotEmpty) {
      bool isLowOrNot =
          stockQuoteData['o'] < stockQuoteData['c'] ? true : false;
      return Text(
        "\$ ${stockQuoteData['c']}",
        style: TextStyle(
          color: isLowOrNot ? Color.fromARGB(255, 47, 255, 0) : Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text('');
    }
  }

  ShapeDecoration _buildContainerDecoration() {
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

  String _showIPOPrice() {
    String ipoDateString = '${companyData['ipo']}';
    DateTime ipoDate = DateTime.parse(ipoDateString);
    String formattedIPODate = DateFormat('MMMM dd, yyyy').format(ipoDate);

    return 'IPO Date: $formattedIPODate';
  }
}
