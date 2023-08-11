// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../Constants/Variable.dart'; // Import for date formatting

class AnimationAreaDefault extends StatefulWidget {
  final symbol;
  final resolution;
  final currentTimestamp;
  final fewDaysAgoTimestamp;

  const AnimationAreaDefault(
      {Key? key,
      this.symbol,
      this.resolution,
      this.currentTimestamp,
      this.fewDaysAgoTimestamp})
      : super(key: key);

  @override
  _AnimationAreaDefaultState createState() => _AnimationAreaDefaultState();
}

class _AnimationAreaDefaultState extends State<AnimationAreaDefault> {
  late List<_ChartData> _chartData;
  late Timer _timer;
  bool _isGoingUp = false;
  late int _minValue;
  late int _maxValue;

  @override
  void initState() {
    super.initState();
    _chartData = [];
    _minValue = 0;
    _maxValue = 0;
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _fetchChartData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchChartData() async {
    final response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/stock/candle?symbol=${widget.symbol}&resolution=${widget.resolution}&from=${widget.fewDaysAgoTimestamp}&to=${widget.currentTimestamp}&token=$apiFinnhub'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<_ChartData> newChartData = [];

      final List<double> values = List.castFrom(data['c']);
      final List<int> timestamps = List.castFrom(data['t']);

      for (int i = 0; i < values.length; i++) {
        final DateTime date =
            DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000);
        var randomValue = values[i];
        newChartData.add(
          _ChartData(date, randomValue),
        );

        if (i == 0) {
          _maxValue = _minValue = randomValue.toInt();
        } else {
          _maxValue = max(_maxValue, randomValue.toInt());
          _minValue = min(_minValue, randomValue.toInt());
        }
      }

      setState(() {
        _chartData = newChartData;
        _isGoingUp = _chartData.first.y <= _chartData.last.y;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildAnimationAreaChart(),
    );
  }

  SfCartesianChart _buildAnimationAreaChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('MMM dd'),
        interval: 1,
      ),
      primaryYAxis: NumericAxis(
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        axisLine: const AxisLine(width: 0),
        minimum: _minValue.toDouble(),
        maximum: _maxValue.toDouble(),
      ),
      series: _getDefaultAreaSeries(),
    );
  }

  List<AreaSeries<_ChartData, DateTime>> _getDefaultAreaSeries() {
    return <AreaSeries<_ChartData, DateTime>>[
      AreaSeries<_ChartData, DateTime>(
        dataSource: _chartData,
        color: _isGoingUp
            ? const Color.fromARGB(255, 202, 245, 203)
            : Color.fromARGB(255, 251, 201, 197),
        borderColor: _isGoingUp ? Colors.green : Colors.red,
        borderWidth: 2,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y,
      ),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}

void main() {
  runApp(MaterialApp(
    home: AnimationAreaDefault(),
  ));
}
