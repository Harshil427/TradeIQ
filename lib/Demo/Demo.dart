// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String source;

  const NewsCard({
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.source,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Add a slight elevation for a visual lift
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Add margins for spacing
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding within the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use AspectRatio to maintain the image's aspect ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10), // Add spacing between image and content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5), // Add spacing between title and content
                  ExpandablePanel(
                    header: Text(
                      "Read more", // Add a header indicating expandability
                      style: TextStyle(
                        color: Colors.blue, // Use a different color for the header
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    collapsed: Text(
                      content,
                      softWrap: true,
                      maxLines: 2, // Show a few lines in collapsed state
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Text(
                      content,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 5), // Add spacing below content
                  Text(
                    source,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
