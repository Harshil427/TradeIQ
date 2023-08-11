// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Constants/Variable.dart';

class CandleChart extends StatefulWidget {
  const CandleChart({Key? key}) : super(key: key);

  @override
  _CandleChartState createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart> {
  late bool _enableSolidCandle;
  late bool _toggleVisibility;
  late TrackballBehavior _trackballBehavior;

  Future<List<ChartSampleData>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://finnhub.io/api/v1/stock/candle?symbol=AAPL&resolution=60&from=1679476980&to=1679649780&token=$apiFinnhub'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ChartSampleData> chartData = [];

      print(data);
      for (var i = 0; i < data['t'].length; i++) {
        print(data['o'][i]);
        print(data['h'][i]);
        print(data['l'][i]);
        print(data['c'][i]);
        chartData.add(
          ChartSampleData(
            x: DateTime.fromMillisecondsSinceEpoch(data['t'][i] * 1000),
            open: data['o'][i],
            high: data['h'][i],
            low: data['l'][i],
            close: data['c'][i],
          ),
        );
      }

      return chartData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    _enableSolidCandle = false;
    _toggleVisibility = true;
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candlestick Chart'),
      ),
      body: FutureBuilder<List<ChartSampleData>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildCandle(snapshot.data!);
          }
        },
      ),
    );
  }

  SfCartesianChart _buildCandle(List<ChartSampleData> chartData) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.Hm(), // Display hours and minutes
        interval: 3, // Adjust the interval as needed
        intervalType: DateTimeIntervalType.hours, // Show data hourly
        minimum: chartData.first.x,
        maximum: chartData.last.x.add(Duration()),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum:
            chartData.map((data) => data.low).reduce((a, b) => a < b ? a : b),
        maximum:
            chartData.map((data) => data.high).reduce((a, b) => a > b ? a : b),
        interval: 0.5,
        labelFormat: r'${value}',
        axisLine: const AxisLine(width: 0),
      ),
      series: _getCandleSeries(chartData),
    );
  }

  List<CandleSeries<ChartSampleData, DateTime>> _getCandleSeries(
      List<ChartSampleData> chartData) {
    return <CandleSeries<ChartSampleData, DateTime>>[
      CandleSeries<ChartSampleData, DateTime>(
        enableSolidCandles: _enableSolidCandle,
        dataSource: chartData,
        showIndicationForSameValues: _toggleVisibility,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        lowValueMapper: (ChartSampleData sales, _) => sales.low,
        highValueMapper: (ChartSampleData sales, _) => sales.high,
        openValueMapper: (ChartSampleData sales, _) => sales.open,
        closeValueMapper: (ChartSampleData sales, _) => sales.close,
        bearColor: Color.fromARGB(
            255, 253, 59, 0), // Customize the color of the candlesticks
      ),
    ];
  }
}

class ChartSampleData {
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;

  ChartSampleData({
    required this.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}

void main() {
  runApp(MaterialApp(home: CandleChart()));
}
