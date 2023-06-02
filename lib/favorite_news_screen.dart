import 'package:flutter/material.dart';

import 'article.dart';

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
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final title = widget.favorites[index].title;
          return ListTile(
            title: Text(title),
          );
        },
      ),
    );
  }
}
