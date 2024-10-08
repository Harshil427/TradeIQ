// ignore_for_file: file_names, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tradeiq/Components/CompanyInfoScreen.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import '../API/api.dart';
import '../Constants/Colors.dart';
import '../Screens/Tools/RecommendationChart.dart';
import '../Widgets/StockNews.dart';
import 'ChartTabScreen.dart';

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
          actions: [
            IconButton(
              onPressed: () {
                addToFav();
              },
              icon: Icon(Icons.star_border),
            ),
          ],
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

  addToFav() async {
    await DatabaseServices().saveDataToFirestore(
      widget.stock['symbol'],
      widget.stock['description'],
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to favorites'),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
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

  Widget buildChartWidgets(BuildContext context) {
    return ChartTabScreen(
      companyData: companyData,
      stockQuoteData: stockQuoteData,
      stock: widget.stock,
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
        Divider(),
        // buildSnapNews(),
        SizedBox(
          height: 10,
        ),
        buildTextNews(),
        buildNewsStock(),
        SizedBox(height: 30)
      ],
    );
  }

  buildTextNews() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'News of ',
          style: TextStyle(fontSize: 22),
        ),
        TextSpan(
          text: '${widget.stock['symbol']}',
          style: TextStyle(fontSize: 22, color: Colors.blue),
        ),
      ]),
    );
  }

  buildNewsStock() {
    return StockNews(
      stock: widget.stock,
    );
  }

  buildSnapNews() {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: TradingViewWidgetHtml(
          widget: TradingViewServices.snapBySymbol(widget.stock['symbol']),
        ),
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
