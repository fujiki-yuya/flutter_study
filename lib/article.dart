
class Article {
  Article({
    required this.title,
    required this.url,
    this.isFavorite = false,
  });

  String title;
  String url;
  bool isFavorite;
}
