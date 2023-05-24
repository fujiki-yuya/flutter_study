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

  @GET('/repos/{owner}/{repo}/pulls')
  Future<List<Pull>> getPulls(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}

@JsonSerializable()
class Issue {
  Issue({
    this.title,
    this.pullRequest,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  final String? title;
  final PullRequest? pullRequest;

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}


@JsonSerializable()
class Pull {
  Pull({this.title});

  factory Pull.fromJson(Map<String, dynamic> json) => _$PullFromJson(json);
  String? title;

  Map<String, dynamic> toJson() => _$PullToJson(this);
}

@JsonSerializable()
class PullRequest {
  PullRequest({
    this.url,
    this.htmlUrl,
    this.diffUrl,
    this.patchUrl,
    this.mergedAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) =>
      _$PullRequestFromJson(json);

  final String? url;
  final String? htmlUrl;
  final String? diffUrl;
  final String? patchUrl;
  final String? mergedAt;

  Map<String, dynamic> toJson() => _$PullRequestToJson(this);
}
