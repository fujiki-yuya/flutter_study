import 'package:count_up_app/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
            url: 'https://www.amazon.co.jp/dp/${_convertJanToIsbn(jan)}'
        ),
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

  Future<String> _scanBarcode() async {
    String barcodeScanResult;
    try {
      barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } catch (e) {
      barcodeScanResult = "Failed to get platform version.";
    }

    if (!mounted) return "";

    return barcodeScanResult;
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
                String barcodeScanResult = await _scanBarcode();
                _onSearchButtonPressed(barcodeScanResult);
              },
              child: const Text('バーコードスキャン'),
            ),
          ],
        ),
      ),
    );
  }
}
