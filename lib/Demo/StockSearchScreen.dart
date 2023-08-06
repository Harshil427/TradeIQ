// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, file_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tradeiq/Constants/Variable.dart';
import 'dart:convert';

import 'StockProfileScreen .dart';

class StockSearchScreen extends StatefulWidget {
  @override
  _StockSearchScreenState createState() => _StockSearchScreenState();
}

class _StockSearchScreenState extends State<StockSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchStocks(String query) async {
    // Make API request to Finnhub to fetch matching stocks
    // Use your own API key from Finnhub
    final apiKey = apiFinnhub;
    final url = 'https://finnhub.io/api/v1/search?q=$query&token=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = List<Map<String, dynamic>>.from(
            json.decode(response.body)['result']);
      });
    } else {
      // Handle API error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _searchController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              _searchStocks(value);
            }
          },
          decoration: InputDecoration(
            labelText: 'Search Stocks',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final stock = _searchResults[index];
              return ListTile(
                title: Text(stock['symbol']),
                subtitle: Text(stock['description']),
                onTap: () {
                  // Navigate to stock profile page passing the selected stock data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockProfileScreen(stock: stock),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
