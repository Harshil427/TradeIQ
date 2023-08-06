// ignore_for_file: use_build_context_synchronously, prefer_const_declarations, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Variable.dart';
import 'package:http/http.dart' as http;
import 'StockChartScreen.dart';

class StockProfileScreen extends StatelessWidget {
  final Map<String, dynamic> stock;

  StockProfileScreen({required this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Profile')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text('Symbol'),
            subtitle: Text(stock['symbol']),
          ),
          ListTile(
            title: Text('Description'),
            subtitle: Text(stock['description']),
          ),
          ElevatedButton(
            onPressed: () {
              // Fetch stock chart data and navigate to the StockChartScreen
              _fetchStockChartData(stock['symbol'], context);
            },
            child: Text('View Chart'),
          ),
        ],
      ),
    );
  }

  void _fetchStockChartData(String symbol, BuildContext context) async {
    final apiKey = apiFinnhub;
    final url =
        'https://finnhub.io/api/v1/stock/candle?symbol=AAPL&resolution=1&from=1679476980&to=1679649780&token=$apiKey';

    final response = await http.get(Uri.parse(url));

    // print('HUGIUDIASBDKBKJDBKJBSKJD');
    // print(symbol);
    // print(response.statusCode);
    // print(json.decode(response.body));

    // if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<double> prices = List<double>.from(data['c']);
    final List<int> timestamps = List<int>.from(data['t']);

    print(data);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StockChartScreen(prices: prices, timestamps: timestamps),
      ),
    );
    // } else {
    // Handle API error
    // }
  }
}
