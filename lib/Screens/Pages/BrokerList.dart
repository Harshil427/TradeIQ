// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/Colors.dart';

class Broker {
  final String name;
  final String website;

  Broker(this.name, this.website);
}

class BestBrokerPage extends StatelessWidget {
  final List<Broker> brokers = [
    Broker('Broker 1', 'https://www.broker1.com'),
    Broker('Broker 2', 'https://www.broker2.com'),
    Broker('Broker 3', 'https://www.broker3.com'),
    // Add more broker data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Best Brokers'),
      ),
      body: ListView.builder(
        itemCount: brokers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(brokers[index].name),
            onTap: () {
              // Open the broker's website in a web view or browser
              launchUrl(brokers[index].website);
            },
          );
        },
      ),
    );
  }

  void launchUrl(String url) async {
    await launch(url);
  }
}
