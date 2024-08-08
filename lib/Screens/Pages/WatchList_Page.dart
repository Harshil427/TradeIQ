// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradeiq/Widgets/WatchList_card.dart';

import '../../Services/Auth_Services.dart';

class WatchlistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(
            AuthServices().getUid(),
          )
          .collection('favrites')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final favorites = snapshot.data!.docs;

        if (favorites.isEmpty) {
          return Center(
            child: Text('No favorite stocks added yet.'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView( // Wrap with SingleChildScrollView
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index].data() as Map<String, dynamic>;
                    final stockName = favorite['name'] ?? '';
                    final description = favorite['description'] ?? '';

                    return WatchListCard(
                      description: description,
                      name: stockName,
                      onRemove: () {
                        // Remove the stock from the user's favorites
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(
                              AuthServices().getUid(),
                            )
                            .collection('favrites')
                            .doc(favorites[index].id)
                            .delete();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
