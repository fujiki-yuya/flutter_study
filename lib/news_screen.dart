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

  final _keywordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _newsApi = NewsApi(_dio);
    _getNews();
  }

  Future<void> _getNews() async {
    try {
      final apiKey = await _checkAPIKey();
      final newsList = await _fetchNews(apiKey);
      final favorites = await readFavorites();
      final articles = _convertArticles(newsList, favorites);

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
  }

  Future<void> _getKeyWordNews(String keyword) async {
    try {
      final apiKey = await _checkAPIKey();
      final newsList = await _fetchKeyWordNews(apiKey, keyword);
      final favorites = await readFavorites();
      final articles = _convertArticles(newsList, favorites);

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
  }

  Future<String> _checkAPIKey() async {
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

  Future<List<News>> _fetchNews(String apiKey) async {
    final response = await _newsApi.getNews(apiKey);
    if (response.articles == null) {
      throw Exception('ニュース記事が取得できません');
    }
    return response.articles!;
  }

  Future<List<News>> _fetchKeyWordNews(String apiKey, String keyword) async {
    final response = await _newsApi.getKeyWordNews(
      apiKey,
      keyword,
    );
    if (response.articles == null) {
      throw Exception('ニュース記事が取得できません');
    }
    return response.articles!;
  }

  // Newsオブジェクトをお気に入り状態を持つArticleオブジェクトに入れる
  List<Article> _convertArticles(List<News> newsList, List<Article> favorites) {
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

  void _onFavoriteButtonPressed(int index) {
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
                builder: (context) => const FavoriteNewsScreen(
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('ニュース検索'),
                    content: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _keywordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '検索キーワードを入力してください';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            _getKeyWordNews(_keywordController.text);
                            Navigator.of(context).pop();
                            _keywordController.clear();
                          }
                        },
                        decoration:
                            const InputDecoration(hintText: '検索キーワードを入力'),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('検索'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _getKeyWordNews(_keywordController.text);
                            Navigator.of(context).pop();
                            _keywordController.clear();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getNews,
          child: Column(
            children: [
              Flexible(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
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
                          _onFavoriteButtonPressed(index);
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
                        if (url == null) {
                          return;
                        }
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
