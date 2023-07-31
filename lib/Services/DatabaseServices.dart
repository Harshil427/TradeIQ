// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Module/User.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeNameOfUser(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set(
          User(
            uid: uid,
            name: name,
            email: email,
            favorites: [],
            alerts: [],
          ).toMap(),
        );
  }

  //
  Future<User?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return User.fromMap(userSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
