import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final Uri uri;
  final String appBarTitle;
  late final WebViewController webViewController;

  WebViewScreen({
    super.key,
    required this.uri,
    this.appBarTitle = 'X',
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
            onPressed: () => context.pop()),
        actions: [
          // open in browser button, like twitter, only text button, no icon
          TextButton(
            onPressed: () async {
              await launchUrlString(uri.toString());
            },
            child: const Text(
              'OPEN IN BROWSER',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
