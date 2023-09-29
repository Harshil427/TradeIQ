// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final String newsUrl;
  final String newsTitle;

  const NewsDetailPage({
    Key? key,
    required this.newsUrl,
    required this.newsTitle,
  }) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    initializeWebViewController();
  }

  void initializeWebViewController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(_createNavigationDelegate())
      ..loadRequest(Uri.parse(widget.newsUrl));
  }

  NavigationDelegate _createNavigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) {
        // Handle progress updates if needed
      },
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith(widget.newsUrl)) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: backgroundColor,
        title: Text(widget.newsTitle),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
