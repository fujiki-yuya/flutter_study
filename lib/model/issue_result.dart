import 'package:freezed_annotation/freezed_annotation.dart';

import 'issue.dart';

part 'issue_result.freezed.dart';

part 'issue_result.g.dart';

@freezed
class IssueResult with _$IssueResult {
  const factory IssueResult({
    int? totalCount,
    bool? incompleteResults,
    List<Issue>? items,
  }) = _IssueResult;

  factory IssueResult.fromJson(Map<String, dynamic> json) =>
      _$IssueResultFromJson(json);
}
