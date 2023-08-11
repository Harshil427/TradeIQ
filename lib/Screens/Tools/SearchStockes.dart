// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tradeiq/Components/StockProfileTrade.dart';
import 'dart:convert';

import 'package:tradeiq/Constants/Variable.dart';
import 'package:tradeiq/Components/StockProfile.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../../Constants/Colors.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({Key? key}) : super(key: key);

  @override
  _SearchStockScreenState createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
        title: const Text('Search'),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildSearchField(),
          _buildSearchResults(),
          SizedBox(
            height: 35,
          )
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchTextChanged,
        decoration: InputDecoration(
          hintText: "Search stocks",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 75, 70, 70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 75, 70, 70),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 75, 70, 70),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('Search for results'),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final stock = _searchResults[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: ListTile(
                title: Text(
                  stock['description'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  stock['symbol'],
                ),
                onTap: () {
                  moveNextPage(
                    context,
                    StockProfileTrade(stock: stock),
                  );
                },
              ),
            );
          },
        ),
      );
    }
  }

  void _onSearchTextChanged(String value) async {
    if (value.isNotEmpty) {
      List<Map<String, dynamic>> results = await _searchStocks(value);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  Future<List<Map<String, dynamic>>> _searchStocks(String query) async {
    final url = 'https://finnhub.io/api/v1/search?q=$query&token=$apiFinnhub';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          json.decode(response.body)['result']);
    } else {
      return []; // Return an empty list on API error
    }
  }
}
