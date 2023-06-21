import 'package:count_up_app/news_webview.dart';
import 'package:flutter/material.dart';

import 'file_helper.dart';
import 'model/article.dart';

class FavoriteNewsScreen extends StatefulWidget {
  const FavoriteNewsScreen({super.key});

  @override
  State<FavoriteNewsScreen> createState() => _FavoriteNewsScreenState();
}

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  late Future<List<Article>> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = readFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りニュース'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            onPressed: () async {
              // お気に入りをすべて削除
              await _cleanFavorite();
              setState(() {
                _favorites = readFavorites();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Article>>(
          future: _favorites,
          builder: (context, snapshot) => switch (snapshot.connectionState) {
            ConnectionState.waiting =>
              const Center(child: CircularProgressIndicator()),
            ConnectionState.done when snapshot.hasError =>
              Center(child: Text('エラーです ${snapshot.error}')),
            ConnectionState.done when !snapshot.hasData =>
              const Center(child: Text('お気に入りのニュースがありません')),
            ConnectionState.done => _favoriteList(snapshot.data!),
            ConnectionState.none => const Center(child: Text('エラー')),
            ConnectionState.active => const Center(child: Text('エラー')),
          },
        ),
      ),
    );
  }

  Widget _favoriteList(List<Article> favorites) {
    return ListView.separated(
      itemCount: favorites.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        final article = favorites[index];
        return ListTile(
          title: Text(article.title),
          trailing: GestureDetector(
            onTap: () async {
              favorites.removeAt(index);
              await writeFavorites(favorites);
              setState(() {
                _favorites = readFavorites();
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
    );
  }

  Future<void> _cleanFavorite() async {
    await writeFavorites([]);
  }
}
