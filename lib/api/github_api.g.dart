// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'title': instance.title,
    };

Pull _$PullFromJson(Map<String, dynamic> json) => Pull(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PullToJson(Pull instance) => <String, dynamic>{
      'title': instance.title,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************


class _GitHubApi implements GitHubApi {
  _GitHubApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.github.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Issue>> getIssues(
    String owner,
    String repo,
  ) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
      _setStreamType<List<Issue>>(
        Options(
          method: 'GET',
          headers: headers,
          extra: extra,
        )
            .compose(
              _dio.options,
              '/repos/$owner/$repo/issues',
              queryParameters: queryParameters,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );
    final value = result.data!
        .map((dynamic i) => Issue.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Pull>> getPulls(
    String owner,
    String repo,
  ) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
      _setStreamType<List<Pull>>(
        Options(
          method: 'GET',
          headers: headers,
          extra: extra,
        )
            .compose(
              _dio.options,
              '/repos/$owner/$repo/pulls',
              queryParameters: queryParameters,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );
    final value = result.data!
        .map((dynamic i) => Pull.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
