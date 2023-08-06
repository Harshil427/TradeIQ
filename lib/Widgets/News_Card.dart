// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/ArticleWebView.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String source;
  final String url;

  NewsCard({
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.source,
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(
              newsTitle: title,
              newsUrl: url,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: FutureBuilder<String?>(
                  future: _loadImage(imageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error loading image');
                    } else if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              ExpandablePanel(
                header: Text(
                  "Read more",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                collapsed: Text(
                  content,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(
                  content,
                  softWrap: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  source,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _loadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return imageUrl;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (error) {
      print('Error loading image: $error');
      return null;
    }
  }
}
