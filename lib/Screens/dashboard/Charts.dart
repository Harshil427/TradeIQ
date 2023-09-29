// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Constants/Variable.dart';
import 'package:tradeiq/Screens/Pages/WatchList_Page.dart';
import 'package:tradeiq/Screens/Tools/SearchStockes.dart';
import 'package:http/http.dart' as http;
import '../../Components/StockScreen.dart';
import '../../Widgets/StocksLokk/TopLosersGainersPage.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  List<Map<String, dynamic>> topGainers = [];
  List<Map<String, dynamic>> topLosers = [];
  final List<Tab> tabs = [
    Tab(text: 'WatchList'),
    Tab(text: 'Stocks'),
    Tab(text: 'OverView')
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading: Icon(
              Icons.auto_graph_outlined,
              color: Colors.white,
            ),
            title: Text('Stocks'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchStockScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
            bottom: TabBar(tabs: tabs),
          ),
          backgroundColor: backgroundColor,
          body: TabBarView(
            children: [
              _buildTabContent(1),
              // Content for Tab 2
              _buildTabContent(2),
              //Content for Tab 3
              _buildTabContent(3),
            ],
          )),
    );
  }

  Widget _buildTabContent(int tabNumber) {
    switch (tabNumber) {
      case 1:
        return SingleChildScrollView(
          child: Column(
            children: [
              WatchlistWidget(),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: Column(
            children: [
              // Add content for Tab 2 here
              buildStocksWidget(context),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          child: Column(
            children: [_buidStockScreen()],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  _buidStockScreen() {
    return Center(
      child: InteractiveViewer(
        child: StockScreen(),
      ),
    );
  }

  buildStocksWidget(BuildContext context) {
    return Column(
      children: [
        topGainers.isEmpty && topLosers.isEmpty
            ? Center(child: CircularProgressIndicator())
            : TopLosersGainersPage(
                topGainers: topGainers, topLosers: topLosers),
      ],
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=$apiAlpha'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final topGainersData = jsonData['top_gainers'];
      final topLosersData = jsonData['top_losers'];

      setState(() {
        topGainers = List<Map<String, dynamic>>.from(topGainersData);
        topLosers = List<Map<String, dynamic>>.from(topLosersData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
