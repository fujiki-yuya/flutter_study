import 'package:count_up_app/favorite_news_screen.dart';
import 'package:count_up_app/news_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'news_state.dart';

final newsStateProvider = ChangeNotifierProvider((ref) => NewsState());

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsStateProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ニュース一覧'),
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (context) => const FavoriteNewsScreen(),
                ),
              );
              await ref.read(newsStateProvider).getNews();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                ref.read(newsStateProvider).getNews();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: ref.read(newsStateProvider).getNews,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: state.news?.articles.length ?? 0,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final title = state.news?.articles[index].title;
                final articleId = state.news?.articles[index].url;
                return ListTile(
                  title: Text(
                    title!,
                  ),
                  trailing: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      if (state.isFavorite(articleId)) {
                        ref
                            .read(newsStateProvider)
                            .removeFromFavorites(articleId);
                      } else {
                        ref.read(newsStateProvider).addToFavorites(articleId);
                      }
                    },
                    child: Icon(
                      state.isFavorite(articleId!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) =>
                            NewsWebView(
                              url: state.news!.articles[index].url!,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
