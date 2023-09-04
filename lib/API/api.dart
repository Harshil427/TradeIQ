// ignore_for_file: avoid_print, unused_element

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants/Variable.dart';

class API {
  // Call market news from API
  Future<List<Map<String, dynamic>>> getMarketNews(String category) async {
    try {
      var url =
          'https://finnhub.io/api/v1/news?category=$category&token=$apiFinnhub';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> items = [];

        for (var item in jsonData) {
          items.add({
            "headline": item["headline"],
            "image": item["image"],
            "source": item["source"],
            "summary": item["summary"],
            "url": item["url"],
          });
        }

        print(items);
        return items;
      } else {
        // Handle non-200 response status codes
        print(
            'Failed to fetch market news. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  //Search Stocks
  Future<List<Map<String, dynamic>>> searchStocks(String query) async {
    final url = 'https://finnhub.io/api/v1/search?q=$query&token=$apiFinnhub';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final searchResults = json.decode(response.body)['result'];
      return List<Map<String, dynamic>>.from(searchResults);
    } else {
      print("API request error: ${response.statusCode}");
      return [];
    }
  }

  // Get stock profile
  Future<Map<String, dynamic>> getStockProfile(String symbol) async {
    final url =
        'https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=$apiFinnhub';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final stockProfile = json.decode(response.body);
      return Map<String, dynamic>.from(stockProfile);
    } else {
      print("API request error: ${response.statusCode}");
      return {};
    }
  }

  Future<Map<String, dynamic>> getStockProfileFromAlpha(String symbol) async {
    final url =
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$apiAlpha';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final stockProfile = json.decode(response.body);
      return Map<String, dynamic>.from(stockProfile);
    } else {
      print("API request error: ${response.statusCode}");
      return {};
    }
  }

  //Get Quote data od stack
  Future<Map<String, dynamic>> fetchStockQuoteData(String symbol) async {
    final url =
        'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiFinnhub';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print("API request error: ${response.statusCode}");
        return {};
      }
    } catch (error) {
      print("Error fetching stock quote data: $error");
      return {};
    }
  }

  // Get Recommendation Data
  Future<List<dynamic>> getRecommendationData(String symbol) async {
    final url =
        'https://finnhub.io/api/v1/stock/recommendation?symbol=$symbol&token=$apiFinnhub';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return data; // Returning a List<dynamic>
      } else {
        print("API request error: ${response.statusCode}");
        return []; // Returning an empty list as default
      }
    } catch (error) {
      print("Error fetching stock recommendation data: $error");
      return []; // Returning an empty list as default
    }
  }

  // Get data for chart
  
}
