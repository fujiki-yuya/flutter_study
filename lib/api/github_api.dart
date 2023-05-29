import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class GitHubApi {
  factory GitHubApi(Dio dio, {String baseUrl}) = _GitHubApi;

  @GET('/search/issues')
  Future<IssueResult> searchIssues(
    @Query('q') String query,
  );

  @GET('/repos/{owner}/{repo}/pulls')
  Future<List<Pull>> getPulls(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}

@JsonSerializable()
class IssueResult {
  IssueResult({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  factory IssueResult.fromJson(Map<String, dynamic> json) =>
      _$IssueResultFromJson(json);

  final int? totalCount;
  final bool? incompleteResults;
  final List<Issue>? items;

  Map<String, dynamic> toJson() => _$IssueResultToJson(this);
}

@JsonSerializable()
class Pull {
  Pull({this.title});

  factory Pull.fromJson(Map<String, dynamic> json) => _$PullFromJson(json);
  String? title;

  Map<String, dynamic> toJson() => _$PullToJson(this);
}

@JsonSerializable()
class Issue {
  Issue({this.title});

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  final String? title;

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}
