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

  void _onSearchButtonPressed(String jan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
            url: 'https://www.amazon.co.jp/dp/${_convertJanToIsbn(jan)}'),
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
    String barcodeScanResult = '';
    try {
      ScanResult result = await BarcodeScanner.scan();
      if (!mounted) return;
      setState(() {
        barcodeScanResult = result.rawContent;
      });

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
                  _onSearchButtonPressed(barcodeScanResult);
                },
                child: const Text('商品ページへ'),
              ),
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
    } catch (e) {
      if (!mounted) return;
      setState(() {
        barcodeScanResult = "Failed to get platform version.";
      });
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
                      //key: _formKey,
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
                      _onSearchButtonPressed(_janController.text);
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
