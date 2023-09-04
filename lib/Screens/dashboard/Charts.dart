// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Screens/Tools/SearchStockes.dart';

import '../../Components/StockScreen.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      backgroundColor: backgroundColor,
      body: _buidStockScreen(),
    );
  }

  _buidStockScreen() {
    return Center(
      child: InteractiveViewer(
        child: StockScreen(),
      ),
    );
  }
}
