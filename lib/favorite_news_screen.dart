import 'package:count_up_app/news_webview.dart';
import 'package:flutter/material.dart';

import 'file_helper.dart';
import 'model/article.dart';

class FavoriteNewsScreen extends StatefulWidget {
  const FavoriteNewsScreen({super.key, required this.favorites});

  final List<Article> favorites;

  @override
  State<FavoriteNewsScreen> createState() => _FavoriteNewsScreenState();
}

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りニュース'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            onPressed: () {
              setState(() {
                widget.favorites.clear();
                writeFavorites(widget.favorites);
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: widget.favorites.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            final article = widget.favorites[index];
            return ListTile(
              title: Text(article.title),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.favorites.removeAt(index);
                    writeFavorites(widget.favorites);
                  });
                },
                child: const Icon(
                  Icons.delete,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => NewsWebView(url: article.url),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
