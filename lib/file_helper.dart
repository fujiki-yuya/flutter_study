import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'model/article.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;

  final file = File('$path/favorites.json');

  final exists = file.existsSync();

  if (!exists) {
    // jsonパースでエラーにならないように空の配列を書き込む
    await file.writeAsString('[]');
  }

  return file;
}

Future<File> writeFavorites(List<Article> favorites) async {
  final file = await _localFile;

  return file.writeAsString(json.encode(favorites));
}

Future<List<Article>> readFavorites() async {
  final file = await _localFile;

  final contents = await file.readAsString();

  final jsonData = json.decode(contents) as List<dynamic>;

  return jsonData
      .map((item) => Article.fromJson(item as Map<String, dynamic>))
      .toList();
}
