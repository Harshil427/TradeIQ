// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradeiq/Utils/Functions.dart';

import 'club_listing_screen.dart';

class ClubCreationScreen extends StatefulWidget {
  const ClubCreationScreen({super.key});

  @override
  _ClubCreationScreenState createState() => _ClubCreationScreenState();
}

class _ClubCreationScreenState extends State<ClubCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _clubNameController,
                decoration: InputDecoration(labelText: 'Club Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a club name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              ElevatedButton(
                onPressed: () {
                  _createClub();
                },
                child: Text('Create Club'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: FloatingActionButton(
          onPressed: () {
            moveNextPage(context, ClubListingScreen());
          },
          child: Icon(Icons.search),
        ),
      ),
    );
  }

  void _createClub() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is authenticated
        final clubName = _clubNameController.text;
        final description = _descriptionController.text;

        // Store club data in Firestore
        final clubData = {
          'clubName': clubName,
          'description': description,
          'adminId': user.uid, // Associate creator's ID as admin
        };

        await FirebaseFirestore.instance.collection('clubs').add(clubData);
        // You can also handle success and navigation here
      } else {
        // User is not authenticated; show an error message or redirect to login
        // You can handle this according to your app's UX design
      }
    }
  }
}
