import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final Uri uri;
  final String appBarTitle;
  late final WebViewController webViewController;

  WebViewScreen({
    super.key,
    required this.uri,
    this.appBarTitle = 'WebView',
  }) {
    webViewController = WebViewController()..loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop()
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => webViewController.reload(),
          ),
        ],
      ),
      body: WebViewWidget(controller: webViewController,),
    );
  }
}