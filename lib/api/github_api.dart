import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class GitHubApi {
  factory GitHubApi(Dio dio, {String baseUrl}) = _GitHubApi;

  @GET('/repos/{owner}/{repo}/issues')
  Future<List<Issue>> getIssues(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}

@JsonSerializable()
class Issue {

  Issue({this.title});

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
  String? title;
  Map<String, dynamic> toJson() => _$IssueToJson(this);
}
