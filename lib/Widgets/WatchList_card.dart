// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:tradeiq/Components/StockProfileTrade.dart';
import 'package:tradeiq/Utils/Functions.dart';

class WatchListCard extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onRemove;

  const WatchListCard({
    Key? key,
    required this.name,
    required this.description,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle priceTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    final stockData = {
      'symbol': name,
      'description': description,
    };

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          '$name',
          style: priceTextStyle.copyWith(fontSize: 24, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$description',
              style: priceTextStyle.copyWith(fontSize: 18),
            ),
          ],
        ),
        onTap: () {
          moveNextPage(
            context,
            StockProfileTrade(
              stock: stockData,
            ),
          );
        },
        trailing: Column(
          children: [
            IconButton(
              onPressed: onRemove, // Call the remove function when the button is pressed
              icon: Icon(
                Icons.remove,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
