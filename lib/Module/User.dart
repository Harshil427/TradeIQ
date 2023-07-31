// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  String name;
  String email;
  List<String> favorites;
  List<String> alerts;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.favorites,
    required this.alerts,
  });

  // Create a factory method to convert a map (usually from Firestore) to a User object
  factory User.fromMap(DocumentSnapshot snap) {
    final map = snap.data() as Map<String, dynamic>;
    return User(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      favorites: List<String>.from(map['favorites']),
      alerts: List<String>.from(map['alerts']),
    );
  }

  // Create a method to convert the User object to a map (usually for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'favorites': favorites,
      'alerts': alerts,
    };
  }
}
