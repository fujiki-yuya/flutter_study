class Article {  // 追加したフィールド

  Article({
    required this.title,
    required this.url,
    this.isFavorite = false,  // 初期値はfalseとする
  });
  String title;
  String url;
  bool isFavorite;
}
