// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradeiq/Components/CompanyInfoScreen.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import 'package:tradeiq/Utils/Functions.dart';
import '../API/api.dart';
import '../Constants/Colors.dart';
import '../Screens/Tools/RecommendationChart.dart';
import 'TradingViewChart.dart';

class StockProfileTrade extends StatefulWidget {
  final stock;

  const StockProfileTrade({Key? key, this.stock}) : super(key: key);

  @override
  State<StockProfileTrade> createState() => _StockProfileTradeState();
}

class _StockProfileTradeState extends State<StockProfileTrade> {
  Map<String, dynamic> companyData = {};
  Map<String, dynamic> stockQuoteData = {};
  var recommendationData = [];
  Map<String, dynamic> companyDataFromAlpha = {};
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchCompanyData();
    _fetchStockQuoteData();
    _fetchRecommendationStock();
    _fetchCompanyDataFromAlpha();

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      _fetchStockQuoteData();
      _fetchRecommendationStock();
    });
  }

  final List<Tab> tabs = [
    Tab(text: 'Chart'),
    Tab(text: 'OverView'),
    Tab(text: 'Specifications')
  ];

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (companyData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return DefaultTabController(
      length: tabs.length, // Number of tabs
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(widget.stock['description']),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Content for Tab 1
            _buildTabContent(1),
            // Content for Tab 2
            _buildTabContent(2),
            //Content for Tab 3
            _buildTabContent(3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tabNumber) {
    switch (tabNumber) {
      case 1:
        return SingleChildScrollView(
          child: Column(
            children: [
              buildChartWidgets(context),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: Column(
            children: [
              // Add content for Tab 2 here
              buildOverViewWidget(context),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          child: Column(
            children: [
              buildStockSpecifications(),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(widget.stock['description']),
    );
  }

  buildStockSpecifications() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompanyInfoScreen(
            companyDataFromAlpha,
          ),
        ],
      ),
    );
  }

  TextStyle textForSpecifications() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  Widget buildChartWidgets(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        _buildStockInfoContainer(width),
        buildDetailsAboutCOH(),
        Divider(),
        buildTradingViewChart(width, context, height),
        SizedBox(
          height: 30,
        ),
        // buildMiniChart(width, height),
        // GestureDetector(
        //   onTap: () {
        // navigateToTradingViewChart();
        //   },
        //   child: buildFullChartButton(width),
        // ),
      ],
    );
  }

  buildTradingViewChart(double width, BuildContext context, double heigth) {
    return SizedBox(
      height: heigth * 0.55,
      width: width * 0.96,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.realTimeChart(widget.stock['symbol'], true),
      ),
    );
  }

  buildOverViewWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        buildTechnicalAnalysis(width, height),
        Divider(),
        _buildAboutMoreStockContainer(),
      ],
    );
  }

  buildDetailsAboutCOH() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('${stockQuoteData['l']}'),
        Text('${stockQuoteData['o']}'),
        Text('${stockQuoteData['h']}'),
        IconButton(
            onPressed: () {
              moveNextPage(
                context,
                TradingViewChart(stock: widget.stock),
              );
            },
            icon: Icon(Icons.fullscreen))
      ],
    );
  }

  Widget buildTradingViewCard(double width, BuildContext context) {
    return SizedBox(
      height: 100,
      width: width * 0.9,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.symbolInfoCard(widget.stock['symbol']),
      ),
    );
  }

  Widget buildMiniChart(double width, double height) {
    return SizedBox(
      height: height * 0.3,
      width: width * 0.9,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.miniChartWidget(widget.stock['symbol']),
      ),
    );
  }

  Widget buildFullChartButton(double width) {
    return Container(
      margin: EdgeInsets.all(30),
      width: width * 0.4,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Full chart >',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
      ),
    );
  }

  void navigateToTradingViewChart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TradingViewChart(stock: widget.stock),
      ),
    );
  }

  Widget buildTechnicalAnalysis(double width, double height) {
    return SizedBox(
      height: height * 0.3,
      width: width * 0.9,
      child: TradingViewWidgetHtml(
        widget:
            TradingViewServices.technicalAnalysisWidget(widget.stock['symbol']),
      ),
    );
  }

  Widget buildCompanyProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 150,
      child: TradingViewWidgetHtml(
        widget:
            TradingViewServices.companyProfileWidget(widget.stock['symbol']),
      ),
    );
  }

  Widget buildSnapBySymbol() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 500,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.snapBySymbol(widget.stock['symbol']),
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

  Container _buildAboutMoreStockContainer() {
    return Container(
      height: 400,
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

  _buildMoreOptionsRowCall() {
    // Check if recommendationData is not empty before accessing its first element
    if (recommendationData.isNotEmpty) {
      return _buildMoreOptionsRow(recommendationData[0]);
    } else {
      // Handle the case when recommendationData is empty (no data to display)
      return Text("No data available");
    }
  }

  Widget _buildMoreOptionsRow(Map<String, dynamic> data) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMoreOptionsColumn('Buy', Colors.green,
              data['buy'].toString()), // Convert 'buy' to a String
          _buildMoreOptionsColumn('Sell', Colors.red,
              data['sell'].toString()), // Convert 'sell' to a String
          _buildMoreOptionsColumn('Hold', Colors.blue,
              data['hold'].toString()), // Convert 'hold' to a String
        ],
      ),
    );
  }

  Widget _buildMoreOptionsColumn(String label, Color color, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color)),
        Text(value),
      ],
    );
  }

  _buildRecommendationChart() {
    return Container(
      height: 300,
      child: RecommendationChart(
        recommendationData,
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

  Future<void> _fetchCompanyDataFromAlpha() async {
    try {
      final data = await API().getStockProfileFromAlpha(widget.stock['symbol']);
      setState(() {
        companyDataFromAlpha = data;
      });
      print(companyDataFromAlpha);
    } catch (error) {
      print("Error fetching company data: $error");
    }
  }
}
