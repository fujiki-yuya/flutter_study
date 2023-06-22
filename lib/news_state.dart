import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api/news_api.dart';
import 'file_helper.dart';
import 'model/article.dart';
import 'model/news_result.dart';

@riverpod
class NewsState extends ChangeNotifier {
  NewsState() {
    getNews();
  }

  Set<String> favoriteArticles = {};

  NewsResult? news;

  Future<void> getNews() async {
    final dio = Dio();
    final newsApi = NewsApi(dio);
    const apiKey = String.fromEnvironment('NEWS_API_KEY');
    final response = await newsApi.getNews(apiKey);
    news = response;
    notifyListeners();
  }

  void addToFavorites(String articleId) {
    favoriteArticles.add(articleId);
    notifyListeners();
  }

  void removeFromFavorites(String articleId) {
    favoriteArticles.remove(articleId);
    notifyListeners();
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
