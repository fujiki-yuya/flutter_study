import 'package:count_up_app/webview_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _janController = TextEditingController();

  void _onSearchButtonPressed(BuildContext context, String jan) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WebViewScreen(
              url: 'https://www.amazon.co.jp/dp/${_convertJanToIsbn(jan)}')),
    );
  }

  String _convertJanToIsbn(String jan) {
    return jan;
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
                      _onSearchButtonPressed(context, _janController.text);
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
