// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tradeiq/Constants/Variable.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
import 'package:tradeiq/Widgets/SnackBar.dart';

class PostThreads extends StatefulWidget {
  const PostThreads({super.key});

  @override
  State<PostThreads> createState() => _PostThreadsState();
}

class _PostThreadsState extends State<PostThreads> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  List<XFile>? _images = [];
  bool isLoading = false;

  Future<void> _getImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 70,
    );

    setState(() {
      _images = pickedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            size: 30,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              String res = await _uploadData();
              if (res == 'Success') {
                showSnackBarSuccess(
                  'Success',
                  'Thread Posted',
                  context,
                );
                Navigator.pop(context);
              } else {
                showSnackBarfail(
                  'Fail',
                  'Some error occurred',
                  context,
                );
              }
              setState(() {
                isLoading = false;
              });
            },
            child: Text(
              'Post now',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          if (isLoading) LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your views, data, and charts...',
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: _getImages,
                    icon: const Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add Media',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (_images != null && _images!.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _images!
                            .map((image) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(File(image.path),
                                      height: 80, width: 80),
                                ))
                            .toList(),
                      ),
                    ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _uploadData() async {
    String res = 'Error...';
    if (_formKey.currentState!.validate()) {
      DatabaseServices().fetchUserData(AuthServices().getUid());
      _formKey.currentState!.save();
      final collection = FirebaseFirestore.instance.collection(threads);
      final docRef = collection.doc();
      await docRef.set({
        'description': _description,
        'upvotes': [],
        'downvotes': [],
        'imageUrls': {},
        'userId': '${AuthServices().getUid()}_${userData!.name}',
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (_images != null && _images!.isNotEmpty) {
        List<String> imageUrls = [];
        for (XFile image in _images!) {
          // Upload each image to Firebase Storage and get the download URL
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('$threads/${docRef.id}/${image.name}');
          firebase_storage.UploadTask uploadTask =
              ref.putFile(File(image.path));
          firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
        await docRef.update({'imageUrls': imageUrls});
      }
      res = 'Success';
    }
    return res;
  }
}
