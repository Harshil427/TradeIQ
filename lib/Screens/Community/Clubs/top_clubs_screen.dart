// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Community/Clubs/club_creation_screen.dart';
import 'package:tradeiq/Screens/Community/Clubs/club_listing_screen.dart';
import 'package:tradeiq/Utils/Functions.dart';

class TopClubsScreen extends StatefulWidget {
  const TopClubsScreen({super.key});

  @override
  State<TopClubsScreen> createState() => _TopClubsScreenState();
}

class _TopClubsScreenState extends State<TopClubsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Test Mode'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              moveNextPage(context, ClubListingScreen());
            },
            child: Icon(Icons.search),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              moveNextPage(context, ClubCreationScreen());
            },
            shape: CircleBorder(),
            child: Icon(Icons.create_new_folder),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
