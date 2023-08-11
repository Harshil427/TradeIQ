// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/Services/TradingViewServices.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewWidgetHtml extends StatefulWidget {
  final widget;
  const TradingViewWidgetHtml({
    super.key,
    this.widget,
  });
  @override
  State<TradingViewWidgetHtml> createState() => _TradingViewWidgetHtmlState();
}

class _TradingViewWidgetHtmlState extends State<TradingViewWidgetHtml> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..clearCache()
      ..goBack()
      ..goForward()
      ..runJavaScript('''
        var style = document.createElement('style');
        style.innerHTML = 'body { font-size: 70px !important; }';
        document.head.appendChild(style);
        ''')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress');
          },
          onPageStarted: (String url) {
            debugPrint('started');
          },
          onPageFinished: (String url) {
            debugPrint('finished');
          },
        ),
      )
      ..enableZoom(true)
      ..loadHtmlString(widget.widget);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
