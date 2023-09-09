// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/API/api.dart';
import 'package:tradeiq/Constants/Colors.dart';

class MarketStatusWidget extends StatefulWidget {
  @override
  _MarketStatusWidgetState createState() => _MarketStatusWidgetState();
}

class _MarketStatusWidgetState extends State<MarketStatusWidget> {
  List<Map<String, dynamic>> marketData = [];

  @override
  void initState() {
    super.initState();
    fetchMarketStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: backgroundColor,
        title: const Text('Market Status'),
      ),
      body: marketData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Open Markets:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    _buildMarketList(true),
                    SizedBox(height: 16),
                    Text(
                      'Closed Markets:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    _buildMarketList(false),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildMarketList(bool isOpen) {
    final filteredMarkets = marketData
        .where(
          (market) => market['current_status'] == (isOpen ? 'open' : 'closed'),
        )
        .toList();

    filteredMarkets.sort(
      (a, b) => a['market_type'].compareTo(b['market_type']),
    );

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: filteredMarkets.length,
        itemBuilder: (context, index) {
          final market = filteredMarkets[index];
          return ListTile(
            title:
                Text('${market["region"]} - ${market["market_type"]} Market'),
            subtitle: Text(
              'Status: ${market["current_status"]}',
              style: TextStyle(
                  color: market["current_status"] == "open"
                      ? Colors.green
                      : Colors.red),
            ),
            trailing: Icon(
              market["current_status"] == "open"
                  ? Icons.check_circle
                  : Icons.remove_circle,
              color: market["current_status"] == "open"
                  ? Colors.green
                  : Colors.red,
            ),
          );
        },
      ),
    );
  }

  fetchMarketStatus() async {
    var tempData = await API().getMarketStatus();
    setState(() {
      marketData = tempData;
    });
  }

  Future<void> _handleRefresh() async {
    await fetchMarketStatus(); // Fetch updated data
    setState(() {
      // Update the UI with the new data
    });
    return Future.delayed(
      Duration(seconds: 2),
    );
  }
}
