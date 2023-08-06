// ignore_for_file: file_names, avoid_print, avoid_web_libraries_in_flutter

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import '../Module/User.dart' as module;
import 'Auth_Services.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeNameOfUser(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set(
          module.User(
            uid: uid,
            name: name,
            email: email,
            favorites: [],
            alerts: [],
          ).toMap(),
        );
  }

  //
  Future<module.User?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return module.User.fromMap(userSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    try {
      String uid = AuthServices().getUid();
      String fileName = 'ProfilePhoto/$uid';
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(fileName);
      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      await DatabaseServices().updateProfileImage(uid, downloadURL);
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  Future<void> updateProfileImage(String userId, String profileImageURL) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profileImage': profileImageURL,
      });
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add image into firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> changeUserProfileImage(
    Uint8List file,
    String uid,
  ) async {
    String res = 'Some error...';

    try {
      if (file != null) {
        String postUrl = await uploadImageToStorage(
          'profileImage',
          file,
          false,
        );

        _firestore.collection('users').doc(uid).update({
          'profileImage': postUrl,
        });
        res = 'Success';
      }
    } on FirebaseException catch (e) {
      res = e.code;
    }
    return res;
  }
}
