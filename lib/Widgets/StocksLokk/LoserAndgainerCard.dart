// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final Map<String, dynamic> stockData;
  final bool isLoser; // Indicates whether it's a loser or not

  // ignore: prefer_const_constructors_in_immutables
  StockCard({required this.stockData, this.isLoser = false});

  @override
  Widget build(BuildContext context) {
    final TextStyle priceTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: isLoser ? Colors.red : Colors.green,
    );

    final String arrowIcon = isLoser ? '🔻' : '🔼';

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        // onTap: moveNextPage(context, ),
        title: Text(
          '${stockData['ticker']}',
          style: priceTextStyle.copyWith(fontSize: 24, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${stockData['price']}',
              style: priceTextStyle.copyWith(fontSize: 18),
            ),
            Text('Change Amount: \$${stockData['change_amount']}'),
          ],
        ),
        trailing: Column(
          children: [
            Text(
              arrowIcon,
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              '${stockData['change_percentage']}',
              style: priceTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
