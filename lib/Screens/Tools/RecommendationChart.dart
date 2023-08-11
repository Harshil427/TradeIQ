// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RecommendationChart extends StatelessWidget {
  final data;

  RecommendationChart(this.data);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 300,
      width: width * 0.92,
      child: BarChart(
        swapAnimationDuration: Duration(),
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 30,
          barTouchData: BarTouchData(
            enabled: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              axisNameWidget: Text('Date'),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    data[value.toInt()]['period'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: getDataBarGroups(),
        ),
      ),
    );
  }

  List<BarChartGroupData> getDataBarGroups() {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < data.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data[i]['buy'].toDouble(),
              color: Colors.blue,
            ),
            BarChartRodData(
              toY: data[i]['hold'].toDouble(),
              color: Colors.orange,
            ),
            BarChartRodData(
              toY: data[i]['sell'].toDouble(),
              color: Colors.red,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}
