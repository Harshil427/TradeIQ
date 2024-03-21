// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import '../../Constants/Colors.dart';
import '../../Services/TradingViewServices.dart';
import '../Tools/TradingViewChart.dart';

class SignalDetailsPage extends StatefulWidget {
  final Map<String, dynamic> stockEntry;

  SignalDetailsPage({required this.stockEntry});

  @override
  State<SignalDetailsPage> createState() => _SignalDetailsPageState();
}

class _SignalDetailsPageState extends State<SignalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SizedBox(height: 40),
          _buildTradingViewWidget(),
          SizedBox(height: 20),
          _buildSignalDetails(),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: const Text('Signal Details'),
    );
  }

  Widget _buildTradingViewWidget() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: height * 0.12,
      width: width,
      child: Center(
        child: TradingViewWidgetHtml(
          widget: TradingViewServices.symbolInfoCard(
            widget.stockEntry['stockName'],
          ),
        ),
      ),
    );
  }

  Widget _buildSignalDetails() {
    return Column(
      children: [
        _buildSignalText(),
        _buildSignalCard(),
      ],
    );
  }

  Widget _buildSignalText() {
    return Text(
      'Signal',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSignalCard() {
    // final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildSignalStatus(),
          _buildSignalDetailsInfo(),
        ],
      ),
    );
  }

  Widget _buildSignalStatus() {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.05,
      decoration: BoxDecoration(
        color: widget.stockEntry['signal'] == 'SignalType.Buy'
            ? Colors.green
            : Colors.red[400],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Text(
            widget.stockEntry['signal'] == 'SignalType.Buy' ? 'Buy' : 'Sell',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Icon(
            widget.stockEntry['signal'] == 'SignalType.Buy'
                ? Icons.moving_rounded
                : Icons.arrow_downward_rounded,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                widget.stockEntry['status'] == 'StatusType.Running'
                    ? 'Running'
                    : 'Closed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildSignalDetailsInfo() {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildSignalInfoRow(
            'Entry Price:',
            widget.stockEntry['stockentryController'].toString(),
          ),
          SizedBox(
            height: 5,
          ),
          _buildSignalInfoRow(
            'Top Profit:',
            widget.stockEntry['takeProfit'].toString(),
          ),
          SizedBox(
            height: 5,
          ),
          _buildSignalInfoRow(
            'Stop Loss:',
            widget.stockEntry['stopLoss'].toString(),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildSignalInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
