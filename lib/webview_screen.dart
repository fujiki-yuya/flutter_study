import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    required this.onScanButtonPressed,
    required this.onProductScanned,
  });

  final String url;
  final VoidCallback onScanButtonPressed;
  final ValueChanged<String> onProductScanned;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  List<String> scannedProducts = []; // スキャンした商品のURLを保持するリスト

  @override
  void initState() {
    super.initState();
    scannedProducts.add(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品画面'),
        actions: <Widget>[
          MaterialButton(
            child: const Text('スキャン'),
            onPressed: () async {
              widget.onScanButtonPressed();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
