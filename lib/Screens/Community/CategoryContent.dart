// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Community/Clubs/top_clubs_screen.dart';
import 'package:tradeiq/Screens/Community/technicalAnalysis.dart';

// import 'Clubs/club_creation_screen.dart';

class CategoryContent extends StatelessWidget {
  final String category;

  CategoryContent({required this.category});

  @override
  Widget build(BuildContext context) {
    // Implement the UI to show discussions related to the selected category.
    // You can fetch and display data from Firebase Firestore or another data source.
    if (category == 'Technical Analysis') {
      return TechnicalAnalysisPage();
    }

    if (category == 'Clubs') {
      return TopClubsScreen();
    }

    return Center(
      child: Text('Discussions in $category category'),
    );
  }
}
