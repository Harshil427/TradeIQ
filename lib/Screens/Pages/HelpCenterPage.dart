// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Help Center'),
      ),
      body: ListView(
        children: <Widget>[
          HelpTopicCard(
            topic: 'Getting Started',
            description: 'Learn how to get started with our app.',
          ),
          HelpTopicCard(
            topic: 'Account Management',
            description: 'Manage your account and profile settings.',
          ),
          HelpTopicCard(
            topic: 'Frequently Asked Questions',
            description: 'Answers to common questions.',
          ),
        ],
      ),
    );
  }
}

class HelpTopicCard extends StatelessWidget {
  final String topic;
  final String description;

  HelpTopicCard({required this.topic, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          // Navigate to a specific help topic or display more information.
          // You can replace this with your own logic.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpTopicDetails(topic: topic),
            ),
          );
        },
        child: ListTile(
          title: Text(topic),
          subtitle: Text(description),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class HelpTopicDetails extends StatelessWidget {
  final String topic;

  HelpTopicDetails({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Help Center - $topic'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Detailed information for the $topic topic will be displayed here.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
