// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/API/api.dart';
import 'package:tradeiq/Widgets/News_Card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String selectedCategory = 'general';
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _fetchMarketNews(category);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMarketNews(selectedCategory);
  }

  Future<void> _fetchMarketNews(String category) async {
    setState(() {
      isLoading = true;
    });

    final newsItems = await API().getMarketNews(category);
    setState(() {
      items = newsItems;
      isLoading = false;
    });
  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () => _onCategorySelected(category),
      child: Text(
        category.toUpperCase(),
        style: TextStyle(
          color: category == selectedCategory ? Colors.blue : Colors.white,
          fontSize: 14,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSampleData() {
    return Container(
      width: 323,
      height: 176,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE544C5), Color(0xFF0CF2B4)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is the future of',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'cryptocurrencies?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(double height) {
    return SizedBox(
      height: height * 0.7,
      // color: Colors.black.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNewsCards() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final newsItem = items[index];

        return NewsCard(
          imageUrl: newsItem['image'],
          title: newsItem['headline'],
          content: newsItem['summary'],
          source: 'Source: ${newsItem['source']}',
          url: newsItem['url'],
        );
      },
      itemCount: items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryButton('general'),
              _buildCategoryButton('forex'),
              _buildCategoryButton('crypto'),
              _buildCategoryButton('merger'),
            ],
          ),
          SizedBox(height: 25),
          if (selectedCategory == 'crypto') _buildSampleData(),
          SizedBox(height: 23),
          isLoading ? _buildLoadingIndicator(heigth) : _buildNewsCards(),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
