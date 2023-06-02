import 'package:freezed_annotation/freezed_annotation.dart';

import 'news.dart';

part 'news_result.freezed.dart';

part 'news_result.g.dart';

@freezed
class NewsResult with _$NewsResult {
  const factory NewsResult({
    String? status,
    int? totalResults,
    List<News>? articles,
  }) = _NewsResult;

  factory NewsResult.fromJson(Map<String, dynamic> json) =>
      _$NewsResultFromJson(json);
}
