// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubDiscussionsScreen extends StatefulWidget {
  final String clubId;

  ClubDiscussionsScreen(this.clubId);

  @override
  _ClubDiscussionsScreenState createState() => _ClubDiscussionsScreenState();
}

class _ClubDiscussionsScreenState extends State<ClubDiscussionsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  List<Discussion> discussions = [];
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load discussions for the specified club
    _loadDiscussions();
  }

  void _loadDiscussions() {
    _database.child('discussions/${widget.clubId}').onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? discussionsMap = event.snapshot.value as Map?;
        discussionsMap!.forEach((key, value) {
          var discussion = Discussion.fromMap(key, value);
          setState(() {
            discussions.add(discussion);
          });
        });
      }
    });
  }

  void _addDiscussion(String text) {
    if (text.isNotEmpty) {
      var newDiscussion = Discussion(
        authorId: user!.uid,
        text: text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      _database
          .child('discussions/${widget.clubId}')
          .push()
          .set(newDiscussion.toMap());
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Discussions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                var discussion = discussions[index];
                return ListTile(
                  title: Text(discussion.text),
                  subtitle: Text('By: ${discussion.authorId}'),
                  // You can add additional UI elements like comment buttons
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(labelText: 'Add a comment'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _addDiscussion(_commentController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Discussion {
  final String authorId;
  final String text;
  final int timestamp;

  Discussion(
      {required this.authorId, required this.text, required this.timestamp});

  Discussion.fromMap(String key, Map<dynamic, dynamic> value)
      : authorId = value['authorId'],
        text = value['text'],
        timestamp = value['timestamp'];

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
