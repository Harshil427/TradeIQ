import 'package:flutter/material.dart';
import 'package:tradeiq/API/api.dart';
import '../Module/News.dart';
import 'News_Card.dart'; // Import your NewsCard widget

class StockNews extends StatefulWidget {
  final stock;
  const StockNews({super.key, this.stock});

  @override
  State<StockNews> createState() => _StockNewsState();
}

class _StockNewsState extends State<StockNews> {
  List<News> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final newsItem = newsList[index];
          return NewsCard(
            imageUrl: newsItem.image,
            title: newsItem.headline,
            content: newsItem.summary,
            source: newsItem.source,
            url: newsItem.url,
          );
        },
      ),
    );
  }

  Future<void> fetchData() async {
    final tempData = await API().fetchStockNews(ticker: widget.stock['symbol']);

    if (tempData.isNotEmpty) {
      // Check if tempData contains more than 5 news articles
      if (tempData.length > 5) {
        // Load up to 5 news articles
        setState(() {
          newsList = tempData.sublist(0, 5);
        });
      } else {
        // Load all news articles
        setState(() {
          newsList = tempData;
        });
      }
    }
  }
}
