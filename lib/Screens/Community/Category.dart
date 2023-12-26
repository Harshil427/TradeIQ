// ignore_for_file: file_names, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';

import '../../Constants/Variable.dart';
import 'CategoryContent.dart';


class CategoryTabView extends StatefulWidget {
  @override
  _CategoryTabViewState createState() => _CategoryTabViewState();
}

class _CategoryTabViewState extends State<CategoryTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Clubs'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Allows horizontal scrolling if there are many categories.
          tabs: categories.map((category) {
            return Tab(text: category);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          // Create a widget for each category's content.
          return CategoryContent(category: category);
        }).toList(),
      ),
    );
  }
}
