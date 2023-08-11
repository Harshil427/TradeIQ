// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Tools/TradingViewChart.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';

import '../Constants/Colors.dart';
import 'TradingViewChart.dart';

class StockProfileTrade extends StatefulWidget {
  final stock;
  const StockProfileTrade({Key? key, this.stock}) : super(key: key);
  @override
  State<StockProfileTrade> createState() => _StockProfileTradeState();
}

class _StockProfileTradeState extends State<StockProfileTrade> {
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: width * 0.9,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.symbolInfoCard(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: heigth * 0.3,
                  width: width * 0.9,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.miniChartWidget(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TradingViewChart(
                          stock: widget.stock,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    width: width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        style: BorderStyle.solid,
                      ),
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
                  ),
                ),
                Divider(),
                SizedBox(
                  height: heigth * 0.3,
                  width: width * 0.9,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.technicalAnalysisWidget(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 200,
                  width: width,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.fundamentalDataWidget(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 150,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.companyProfileWidget(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 500,
                  child: TradingViewWidgetHtml(
                    widget: TradingViewServices.snapBySymbol(
                      widget.stock['symbol'],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        widget.stock['description'],
      ),
    );
  }
}
