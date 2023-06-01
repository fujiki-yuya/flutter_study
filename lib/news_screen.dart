import 'package:count_up_app/news_webview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api/news_api.dart';
import 'model/news_result.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsResult? _news;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    final dio = Dio();
    final newsApi = NewsApi(dio);
    final apiKey = dotenv.env['NEWS_API_KEY'];
    final response = await newsApi.getNews(apiKey!);
    setState(() {
      _news = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ニュース一覧'),
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Flexible(
                child: ListView.builder(
                  itemCount: _news?.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    final title = _news?.articles?[index].title;
                    return ListTile(
                      title: Text(
                        title!,
                      ),
                      trailing: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          // お気に入りボタンが押された時の処理
                        },
                        child: const Icon(Icons.favorite),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (context) => NewsWebView(
                              url: _news!.articles![index].url!,
                            ),
                          ),
                        );
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
