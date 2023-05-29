import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue.freezed.dart';

part 'issue.g.dart';

@freezed
class Issue with _$Issue {
  const factory Issue({required String? title}) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

}
