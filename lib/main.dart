import 'package:count_up_app/seatch_repository_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHubリポジトリ検索',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const SearchRepositoryScreen(),
    );
  }
}
