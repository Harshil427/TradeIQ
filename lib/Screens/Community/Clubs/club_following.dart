// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubFollowingScreen extends StatefulWidget {
  @override
  _ClubFollowingScreenState createState() => _ClubFollowingScreenState();
}

class _ClubFollowingScreenState extends State<ClubFollowingScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<String> followedClubIds = [];

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _loadFollowedClubs();
    }
  }

  void _loadFollowedClubs() async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    if (userData.exists) {
      setState(() {
        followedClubIds = List<String>.from(userData.data()?['followedClubs']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow Clubs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final clubs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              final club = clubs[index];
              final isFollowed = followedClubIds.contains(club.id);

              return ListTile(
                title: Text(club['clubName']),
                subtitle: Text(club['description']),
                trailing: isFollowed
                    ? ElevatedButton(
                        onPressed: () => _unfollowClub(club.id),
                        child: Text('Unfollow'),
                      )
                    : ElevatedButton(
                        onPressed: () => _followClub(club.id),
                        child: Text('Follow'),
                      ),
              );
            },
          );
        },
      ),
    );
  }

  void _followClub(String clubId) {
    // Add club to the user's followed clubs list
    followedClubIds.add(clubId);
    _updateFollowedClubs();
  }

  void _unfollowClub(String clubId) {
    // Remove club from the user's followed clubs list
    followedClubIds.remove(clubId);
    _updateFollowedClubs();
  }

  void _updateFollowedClubs() {
    // Update the user's profile with the new followed clubs list
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
      {
        'followedClubs': followedClubIds,
      },
      SetOptions(merge: true),
    );
  }
}
