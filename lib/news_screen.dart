import 'package:count_up_app/news_webview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api/news_api.dart';
import 'favorite_news_screen.dart';
import 'file_helper.dart';
import 'model/article.dart';
import 'model/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final Dio _dio = Dio();
  late final NewsApi _newsApi;
  List<Article>? _article;

  @override
  void initState() {
    super.initState();
    _newsApi = NewsApi(_dio);
    getNews();
  }

  Future<void> getNews() async {
    try {
      final apiKey = await checkAPIKey();
      final newsList = await fetchNews(apiKey);
      final favorites = await fetchFavorites();
      final articles = convertArticles(newsList, favorites);

      setState(() {
        _article = articles;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('エラーです。$e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    // 取得したニュースにお気に入り状態を反映
    await readFavoritesOnStart();
  }

  Future<String> checkAPIKey() async {
    final apiKey = dotenv.env['NEWS_API_KEY'];
    if (apiKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('APIキーが設定されていません'),
          duration: Duration(seconds: 3),
        ),
      );
      throw Exception('APIキーが設定されていません');
    }
    return apiKey;
  }

  Future<List<News>> fetchNews(String apiKey) async {
    final response = await _newsApi.getNews(apiKey);
    if (response.articles == null) {
      throw Exception('ニュース記事が取得できません');
    }
    return response.articles!;
  }

  Future<List<Article>> fetchFavorites() async {
    return readFavorites();
  }

  // Newsオブジェクトをお気に入り状態を持つArticleオブジェクトに入れる
  List<Article> convertArticles(List<News> newsList, List<Article> favorites) {
    return newsList.map((News news) {
      final isFavorite =
          favorites.any((favoriteArticle) => favoriteArticle.url == news.url);

      return Article(
        title: news.title ?? '',
        url: news.url ?? '',
        isFavorite: isFavorite,
      );
    }).toList();
  }

  Future<void> readFavoritesOnStart() async {
    final favorites = await readFavorites();
    for (final favorite in favorites) {
      //現在並んでいる記事とお気に入りの記事のurlが同じ場合にisFavoriteをtrueに
      final index = _article?.indexWhere((item) => item.url == favorite.url);
      // indexWhereが条件に一致しない場合に -1 を返すため
      if (index != null && index != -1) {
        //_article?[index].isFavorite = true;
        final article = _article![index];
        _article![index] = article.copyWith(isFavorite: true);
      }
    }
    setState(() {});
  }

  void onFavoriteButtonPressed(int index) {
    if (_article != null) {
      setState(() {
        final article = _article![index];
        _article![index] = article.copyWith(isFavorite: !article.isFavorite);

        final favorites =
            (_article ?? []).where((article) => article.isFavorite).toList();

        writeFavorites(favorites);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ニュース一覧'),
        leading: IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () async {
            final favorites = await readFavorites();
            if (!mounted) {
              return;
            }
            await Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (context) => FavoriteNewsScreen(
                  favorites: favorites,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: getNews,
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: getNews,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  itemCount: _article?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    final title = _article?[index].title;
                    return ListTile(
                      title: Text(
                        title ?? 'ニュースがありません',
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          onFavoriteButtonPressed(index);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: _article?[index].isFavorite == true
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                      onTap: () async {
                        final url = _article?[index].url;
                        if (url != null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (context) => NewsWebView(
                                url: url,
                              ),
                            ),
                          ).catchError((dynamic e) {
                            return AlertDialog(
                              title: const Text('ニュースを表示できません'),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('閉じる'),
                                ),
                              ],
                            );
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
