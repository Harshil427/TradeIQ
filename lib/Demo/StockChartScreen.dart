// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StockChartScreen extends StatelessWidget {
  final List<double> prices;
  final List<int> timestamps;

  StockChartScreen({required this.prices, required this.timestamps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Chart')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _generateSpots(),
                isCurved: true,
                color: Colors.blue,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            minX: timestamps.first.toDouble(),
            maxX: timestamps.last.toDouble(),
            minY: prices.reduce((min, value) => min > value ? value : min),
            maxY: prices.reduce((max, value) => max < value ? value : max),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    for (int i = 0; i < prices.length; i++) {
      spots.add(FlSpot(timestamps[i].toDouble(), prices[i]));
    }
    return spots;
  }
}
