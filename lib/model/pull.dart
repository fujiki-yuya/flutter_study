import 'package:freezed_annotation/freezed_annotation.dart';

part 'pull.freezed.dart';

part 'pull.g.dart';

@freezed
class Pull with _$Pull {
  const factory Pull({required String? title}) = _Pull;

  factory Pull.fromJson(Map<String, dynamic> json) => _$PullFromJson(json);
}
