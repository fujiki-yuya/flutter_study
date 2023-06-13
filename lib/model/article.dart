import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
@immutable
class Article {
  const Article({
    required this.title,
    required this.url,
    required this.isFavorite,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  final String title;
  final String url;
  final bool isFavorite;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  Article copyWith({bool? isFavorite}) {
    return Article(
      title: title,
      url: url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
