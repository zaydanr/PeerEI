import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GTResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GT Resources'),
      ),
      body: WebView(
        initialUrl: 'https://visionary-brigadeiros-94084c.netlify.app/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
