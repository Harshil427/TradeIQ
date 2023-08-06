// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';

import '../../Utils/Functions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isEditable = false;
  late String _profileName = '';
  late String _profileImage = '';
  late String _email = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _email = userData['email'];
          _profileName = userData['name'];
          _profileImage = userData['profileImage'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildProfilePicture(),
              SizedBox(height: 20),
              buildProfileNameField(),
              SizedBox(height: 20),
              buildEmailText(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor, // Customize the color as needed.
      title: Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _isEditable = !_isEditable;
            });
          },
          icon: Icon(
            _isEditable ? Icons.check : Icons.edit,
          ),
        ),
      ],
    );
  }

  Widget buildProfilePicture() {
    return Stack(
      children: [
        _profileImage.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(_profileImage),
                radius: 60,
              )
            : CircleAvatar(
                radius: 60,
                child: Icon(Icons.person),
              ),
        if (_isEditable)
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () async {
                pickImageFromGallery();
              },
              icon: Icon(
                Icons.photo_library_outlined,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildProfileNameField() {
    return _isEditable
        ? TextFormField(
            initialValue: _profileName,
            onChanged: (value) {
              setState(() {
                _profileName = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Profile Name',
            ),
          )
        : Text(
            _profileName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
  }

  Widget buildEmailText() {
    return Text(
      'Email: $_email',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    );
  }

  Future<Uint8List?> pickImageFromGallery() async {
    Uint8List pickedImage = await pickImage(ImageSource.gallery);

    if (pickedImage != null) {
      DatabaseServices().changeUserProfileImage(
        pickedImage,
        AuthServices().getUid(),
      );
      return Uint8List(0);
    }
    return null;
  }
}
