// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewsResult _$$_NewsResultFromJson(Map<String, dynamic> json) =>
    _$_NewsResult(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_NewsResultToJson(_$_NewsResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
