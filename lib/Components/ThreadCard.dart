// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Services/Auth_Services.dart';

class ThreadCard extends StatefulWidget {
  final DocumentSnapshot thread;

  ThreadCard({required this.thread});

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  var upvotes = 0;
  var downvotes = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    final upvotesList = widget.thread['upvotes'] as List<dynamic>? ?? [];
    final downvotesList = widget.thread['downvotes'] as List<dynamic>? ?? [];

    setState(() {
      upvotes = upvotesList.length;
      downvotes = downvotesList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Extract relevant thread data, providing default values for null data.

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              // Display user profile photo if available.
              backgroundImage: NetworkImage(
                  'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg'),
            ),
            title: Text(userName()), // Display the user's name.
            subtitle: Text(timeStamp()), // Display the timestamp.
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 80,
            ),
            child: Text(description()), // Display the thread description.
          ),
          // Display images if available.
          if (widget.thread['imageUrls']
              is List) // Check if imageUrls is a list.
            Container(
              margin: EdgeInsets.only(
                left: 80,
              ),
              height: 100, // Set the height to control image size.
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.thread['imageUrls'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle image click to open a preview.
                      showImagePreview(
                          context, widget.thread['imageUrls'][index]);
                    },
                    child: Image.network(
                      widget.thread['imageUrls'][index],
                      width: 100, // Set the width to control image size.
                      height: 100,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image is loaded.
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        ); // Display loading indicator while loading.
                      },
                      errorBuilder: (context, error, stackTrace) {
                        // Handle error (e.g., display a placeholder or skip the image).
                        return SizedBox(
                            width: 100,
                            height: 100); // Placeholder for failed image.
                      },
                    ),
                  );
                },
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  upvote();
                },
              ),
              Text(upvotes.toString()), // Display upvote count.
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: () {
                  downvote();
                },
              ),
              Text(downvotes.toString()), // Display downvote count.
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Implement comment functionality.
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String userName() {
    String uid =
        widget.thread['userId']; // Replace this with your actual user ID
    List<String> name = uid.split('_');
    if (name.length >= 2) {
      return name[1];
    } else {
      // Handle the case where there might not be a second part after splitting
      return "NoName"; // You can choose a different default value or handle it as needed.
    }
  }

  String description() {
    String desc = widget.thread['description'];
    if (desc.isNotEmpty) {
      return desc;
    } else {
      return "No Description";
    }
  }

  String timeStamp() {
    dynamic timestampData = widget.thread['timestamp'];

    if (timestampData != null && timestampData is Timestamp) {
      Timestamp time = timestampData;
      return time.toDate().toString();
    } else {
      // Handle the case where the 'timestamp' field is missing or null.
      return "Timestamp Not Available";
    }
  }

  void showImagePreview(BuildContext context, String imageUrl) {
    // You can create a dialog or a custom widget to display the image preview.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Image.network(imageUrl),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  bool hasVotedUp = false;

  void upvote() {
    if (!hasVotedUp) {
      setState(() {
        upvotes++;
        hasVotedUp = true; // Mark the user as having voted
      });

      // Update the Firestore document to record the upvote
      FirebaseFirestore.instance
          .collection('technical_analysis_threads')
          .doc(widget.thread.id)
          .update({
        'upvotes': FieldValue.arrayUnion([AuthServices().getUid()]),
        'downvotes': FieldValue.arrayRemove([AuthServices().getUid()]),
      });
    }
  }

  void downvote() {
    if (hasVotedUp) {
      setState(() {
        downvotes++;
        hasVotedUp = false; // Mark the user as having voted
      });

      // Update the Firestore document to record the downvote
      FirebaseFirestore.instance
          .collection('technical_analysis_threads')
          .doc(widget.thread.id)
          .update({
        'downvotes': FieldValue.arrayUnion([AuthServices().getUid()]),
        'upvotes': FieldValue.arrayRemove([AuthServices().getUid()]),
      });
    }
  }
}
