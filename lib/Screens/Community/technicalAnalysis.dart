// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../../Components/ThreadCard.dart';
import 'postThreads.dart';

class TechnicalAnalysisPage extends StatefulWidget {
  @override
  _TechnicalAnalysisPageState createState() => _TechnicalAnalysisPageState();
}

class _TechnicalAnalysisPageState extends State<TechnicalAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('technical_analysis_threads')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data == null) {
            return Center(
              child: Text('No post Avaiable'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final threads = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: threads.length,
            itemBuilder: (context, index) {
              final thread = threads[index];
              return ThreadCard(thread: thread);
            },
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.blue[600],
          onPressed: () {
            moveNextPage(
              context,
              PostThreads(),
            );
          },
          child: Icon(
            Icons.edit,
          ),
        ),
      ),
    );
  }
}
