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

  return File('$path/favorites.json');
}

Future<File> writeFavorites(List<Article> favorites) async {
  print('writeFavoritesが呼ばれました');


  final file = await _localFile;

  return file.writeAsString(json.encode(favorites));
}

Future<List<Article>> readFavorites() async {
  try {
    final file = await _localFile;

    final contents = await file.readAsString();

    final jsonData = json.decode(contents) as List<dynamic>;

    return jsonData
        .map((item) => Article.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    return [];
  }
}
