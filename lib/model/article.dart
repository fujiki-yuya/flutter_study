import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Article({
    required this.title,
    required this.url,
    required this.isFavorite,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  String title;
  String url;
  bool isFavorite;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
