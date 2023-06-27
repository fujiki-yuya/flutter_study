import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api/news_api.dart';
import 'file_helper.dart';
import 'model/article.dart';
import 'model/news_result.dart';

class NewsState extends StateNotifier<NewsResult?> {
  NewsState() : super(null) {
    getNews();
  }

  Set<String> favoriteArticles = {};

  Future<void> getNews() async {
    final dio = Dio();
    final newsApi = NewsApi(dio);
    const apiKey = String.fromEnvironment('NEWS_API_KEY');
    final response = await newsApi.getNews(apiKey);
    state = response;
  }

  void addToFavorites(String articleId) {
    favoriteArticles.add(articleId);
  }

  void removeFromFavorites(String articleId) {
    favoriteArticles.remove(articleId);
  }

  Future<void> removeAllFavorites() async {
    await writeFavorites([]);
  }

  bool isFavorite(String articleId) {
    return favoriteArticles.contains(articleId);
  }

  Future<List<Article>> getFavoriteArticles() async {
    return readFavorites();
  }
}
