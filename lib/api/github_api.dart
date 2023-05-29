import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../model/issue_result.dart';
import '../model/pull.dart';

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
