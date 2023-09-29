// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';

import 'LoserAndgainerCard.dart';

// Define the StockCard widget (code from the previous response).

class TopLosersGainersPage extends StatelessWidget {
  final List<Map<String, dynamic>> topGainers;
  final List<Map<String, dynamic>> topLosers;

  TopLosersGainersPage({required this.topGainers, required this.topLosers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Gainers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildStockList(topGainers,
              isLoser: false), // Pass isLoser as false for gainers
          SizedBox(height: 16),
          Text(
            'Top Losers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildStockList(topLosers,
              isLoser: true), // Pass isLoser as true for losers
        ],
      ),
    );
  }

  Widget _buildStockList(List<Map<String, dynamic>> stockData,
      {required bool isLoser}) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: stockData.length,
      itemBuilder: (context, index) {
        final stock = stockData[index];
        return StockCard(stockData: stock, isLoser: isLoser);
      },
    );
  }
}
