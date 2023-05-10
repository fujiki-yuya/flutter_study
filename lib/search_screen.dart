import 'package:barcode_scan2/barcode_scan2.dart';
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
    String url = 'https://www.amazon.co.jp/dp/${_convertJanToIsbn(jan)}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  String _convertJanToIsbn(String jan) {
    if (jan.length == 13) {
      String isbn = jan.substring(3, 12);
      int checkDigit = 0;
      for (int i = 0; i < 9; i++) {
        checkDigit += int.parse(isbn[i]) * (i + 1);
      }
      checkDigit %= 11;
      if (checkDigit == 10) {
        isbn += 'X';
      } else {
        isbn += checkDigit.toString();
      }
      return isbn;
    }
    return '';
  }

  Future<void> _scanBarcode() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      if (!mounted) return;


      // スキャンした時に商品ページを表示
      _navigateToWebView(result.rawContent);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('バーコードを読み取りました'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _scanBarcode();
                },
                child: const Text('スキャン'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('商品確認'),
              ),
            ],
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
