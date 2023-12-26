// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClubListingScreen extends StatefulWidget {
  const ClubListingScreen({super.key});

  @override
  _ClubListingScreenState createState() => _ClubListingScreenState();
}

class _ClubListingScreenState extends State<ClubListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _clubs = [];
  List<QueryDocumentSnapshot> _filteredClubs = [];

  @override
  void initState() {
    super.initState();
    // Fetch club data from Firestore when the screen is initialized
    _fetchClubs();
  }

  void _fetchClubs() async {
    final clubsSnapshot = await FirebaseFirestore.instance.collection('clubs').get();
    setState(() {
      _clubs = clubsSnapshot.docs;
      _filteredClubs = _clubs;
    });
  }

  void _filterClubs(String query) {
    setState(() {
      _filteredClubs = _clubs
          .where((club) =>
              club['clubName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Listing'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                _filterClubs(query);
              },
              decoration: InputDecoration(
                labelText: 'Search Clubs',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredClubs.length,
              itemBuilder: (context, index) {
                final club = _filteredClubs[index];
                return ListTile(
                  title: Text(club['clubName']),
                  subtitle: Text(club['description']),
                  // You can add more UI elements for each club, like buttons to follow or join the club
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
