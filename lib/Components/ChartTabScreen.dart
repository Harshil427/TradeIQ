// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Screens/Tools/TradingViewChart.dart';
import '../Services/TradingViewServices.dart';
import '../Utils/Functions.dart';
import 'TradingViewChart.dart';

class ChartTabScreen extends StatefulWidget {
  final companyData;
  final stockQuoteData;
  final stock;
  const ChartTabScreen({super.key, this.companyData, this.stockQuoteData, this.stock});

  @override
  State<ChartTabScreen> createState() => _ChartTabScreenState();
}

class _ChartTabScreenState extends State<ChartTabScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _buildStockInfoContainer(width),
        buildDetailsAboutCOH(),
        Divider(),
        buildTradingViewChart(width, context, height),
        SizedBox(
          height: 30,
        ),
        // buildMiniChart(width, height),
        // GestureDetector(
        //   onTap: () {
        // navigateToTradingViewChart();
        //   },
        //   child: buildFullChartButton(width),
        // ),
      ],
    );
  }

  Widget _buildStockInfoContainer(double width) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 100,
      decoration: _buildContainerDecoration(),
      child: Row(
        children: [
          SizedBox(width: 10),
          _buildStockAvatar(),
          SizedBox(width: 20),
          _buildCompanyDetailsColumn(),
          Spacer(),
          _buildStockPriceText(),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  ShapeDecoration _buildContainerDecoration() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, -1.00),
        end: Alignment(0, 1),
        colors: [
          Color.fromARGB(255, 0, 255, 183),
          Color.fromARGB(221, 3, 200, 255),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildStockAvatar() {
    if (widget.companyData['logo'] != null) {
      return CircleAvatar(
        child: SvgPicture.network(widget.companyData['logo']),
        radius: 25,
      );
    } else {
      return CircleAvatar(
        radius: 30,
        child: Icon(Icons.image),
      );
    }
  }

  Row _buildCompanyDetailsColumn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.companyData['ticker'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Text _buildStockPriceText() {
    if (widget.stockQuoteData.isNotEmpty) {
      bool isLowOrNot =
          widget.stockQuoteData['o'] < widget.stockQuoteData['c'] ? true : false;
      return Text(
        "\$ ${widget.stockQuoteData['c']}",
        style: TextStyle(
          color: isLowOrNot ? Color.fromARGB(255, 47, 255, 0) : Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text('');
    }
  }

  buildDetailsAboutCOH() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('${widget.stockQuoteData['l']}'),
        Text('${widget.stockQuoteData['o']}'),
        Text('${widget.stockQuoteData['h']}'),
        IconButton(
            onPressed: () {
              moveNextPage(
                context,
                TradingViewChart(stock: widget.stock),
              );
            },
            icon: Icon(Icons.fullscreen))
      ],
    );
  }

  buildTradingViewChart(double width, BuildContext context, double heigth) {
    return SizedBox(
      height: heigth * 0.55,
      width: width * 0.96,
      child: TradingViewWidgetHtml(
        widget: TradingViewServices.realTimeChart(widget.stock['symbol'], true),
      ),
    );
  }
}
