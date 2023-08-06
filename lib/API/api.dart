// ignore_for_file: avoid_print

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
}
