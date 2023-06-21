// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'api/news_api.dart';
// import 'model/article.dart';
// import 'model/news_result.dart';
//
//
// final articleListProvider = StateProvider<List<Article>>((ref) => []);
// final loadingStateProvider = StateProvider<bool>((ref) => false);
//
// final dioProvider = Provider<Dio>((ref) => Dio());
//
// final newsApiProvider =
//     Provider<NewsApi>((ref) => NewsApi(ref.read(dioProvider)));
//
// final newsProvider = FutureProvider<NewsResult>((ref) {
//   final dio = Dio();
//   final newsApi = NewsApi(dio);
//   final apiKey = dotenv.env['NEWS_API_KEY'];
//   return newsApi.getNews(apiKey!);
// });
//
// final favoriteStateProvider = StateProvider<bool>((ref) => false);
