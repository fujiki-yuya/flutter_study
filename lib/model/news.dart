import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';

part 'news.g.dart';

@freezed
class News with _$News {
  const factory News({
    required String? title,
    required String? url,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
