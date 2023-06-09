import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:count_up_app/jan_to_isbn_string_extension.dart';
import 'package:count_up_app/scan_result_dialog.dart';
import 'package:count_up_app/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _janController = TextEditingController();
  List<String> scannedProducts = [];

  void _navigateToWebView(String jan) {
    try {
      final isbn = jan.convertJanToIsbn();
      final url = 'https://www.amazon.co.jp/dp/$isbn';

      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (context) => WebViewScreen(
            url: url,
            onScanButtonPressed: _scanBarcode2,
            onProductScanned: (newUrl) {
              setState(() {
                scannedProducts.add(newUrl);
              });
            },
          ),
        ),
      );
    } on FormatException catch (e) {
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _scanBarcode() async {
    // 開いているキーボードを閉じるためにフォーカスを外す
    FocusScope.of(context).unfocus();

    try {
      final result = await BarcodeScanner.scan();
      if (!mounted) {
        return;
      }

      // バックボタンを押したらスキャンを終了する
      if (result.rawContent.isEmpty) {
        return;
      }

      // スキャンした時に商品ページを表示
      _navigateToWebView(result.rawContent);

      await ScanResultDialog.show(
        context: context,
        onScanPressed: () async {
          Navigator.of(context).pop();
          await _scanBarcode();
        },
        onCheckPressed: () {
          Navigator.of(context).pop();
        },
      );
    } on PlatformException {
      if (!mounted) {
        return;
      }
    }
  }

  void _navigateToWebView2(String jan) {
    try {
      final isbn = jan.convertJanToIsbn();
      final url = 'https://www.amazon.co.jp/dp/$isbn';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute<Widget>(
          builder: (context) => WebViewScreen(
            url: url,
            onScanButtonPressed: _scanBarcode2,
            onProductScanned: (newUrl) {
              setState(() {
                scannedProducts.add(newUrl);
              });
            },
          ),
        ),
      );
    } on FormatException catch (e) {
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _scanBarcode2() async {
    // 開いているキーボードを閉じるためにフォーカスを外す
    FocusScope.of(context).unfocus();

    try {
      final result = await BarcodeScanner.scan();
      if (!mounted) {
        return;
      }

      // バックボタンを押したらスキャンを終了する
      if (result.rawContent.isEmpty) {
        return;
      }

      // スキャンした時に商品ページを表示
      _navigateToWebView2(result.rawContent);
    } on PlatformException {
      if (!mounted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('書籍検索'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          controller: _janController,
                          decoration: const InputDecoration(
                            labelText: 'JANコードを入力してください',
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _navigateToWebView(_janController.text);
                      },
                      child: const Text('検索'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () async {
                  await _scanBarcode();
                },
                child: const Text('バーコードスキャン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
