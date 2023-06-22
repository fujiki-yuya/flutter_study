import 'package:count_up_app/news_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ニュース',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const NewsScreen(),
    );
  }
}
