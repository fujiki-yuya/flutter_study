import 'package:count_up_app/webview_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  void _onSearchButtonPressed(BuildContext context, int jan) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WebViewScreen(url: 'https://www.amazon.co.jp/')),
    );
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
                        decoration: const InputDecoration(
                          labelText: 'JANコードを入力してください',
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _onSearchButtonPressed(context, 0);
                    },
                    child: const Text('検索'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
