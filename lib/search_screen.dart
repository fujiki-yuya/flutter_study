import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:count_up_app/jan_to_isbn_string_extension.dart';
import 'package:count_up_app/scan_result_dialog.dart';
import 'package:count_up_app/webview_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _janController = TextEditingController();

  void _navigateToWebView(String jan) {
    try {
      String isbn = jan.convertJanToIsbn();
      String url = 'https://www.amazon.co.jp/dp/$isbn';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url),
        ),
      );
    } catch (e) {
      showDialog(
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
      ScanResult result = await BarcodeScanner.scan();
      if (!mounted) return;

      // バックボタンを押したらスキャンを終了する
      if (result.rawContent.isEmpty) {
        return;
      }

      // スキャンした時に商品ページを表示
      _navigateToWebView(result.rawContent);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ScanResultDialog(
            onScanPressed: () async {
              Navigator.of(context).pop();
              await _scanBarcode();
            },
            onCheckPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
