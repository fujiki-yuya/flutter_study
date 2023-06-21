import 'package:count_up_app/news_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/article.dart';
import 'news_screen.dart';

class FavoriteNewsScreen extends ConsumerWidget {
  const FavoriteNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesFutureProvider = FutureProvider<List<Article>>(
        (ref) => ref.read(newsStateProvider).getFavoriteArticles());

    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りニュース'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            onPressed: () async {
              // お気に入りをすべて削除
              await ref.read(newsStateProvider).removeAllFavorites();
              ref.refresh(favoritesFutureProvider);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, WidgetRef ref, _) {
            final favoritesSnap = ref.watch(favoritesFutureProvider);
            return favoritesSnap.when(
              data: (favorites) =>
                  _favoriteList(favorites, ref, favoritesFutureProvider),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラーです $e')),
            );
          },
        ),
      ),
    );
  }

  Widget _favoriteList(List<Article> favorites, WidgetRef ref,
      FutureProvider<List<Article>> favoritesFutureProvider) {
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
              ref.read(newsStateProvider).removeFromFavorites(article.url);
              ref.refresh(favoritesFutureProvider);
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
}
