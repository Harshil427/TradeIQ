// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hide/Show Navigation Bar'),
        ),
        body: ScrollHideNavBar(),
      ),
    );
  }
}

class ScrollHideNavBar extends StatefulWidget {
  @override
  _ScrollHideNavBarState createState() => _ScrollHideNavBarState();
}

class _ScrollHideNavBarState extends State<ScrollHideNavBar> {
  late ScrollController _scrollController;
  bool _isVisible = true;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _isVisible =
            _scrollController.position.userScrollDirection == ScrollDirection.forward;
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 100, // Replace this with your actual list size
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }
}
