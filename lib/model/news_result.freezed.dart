// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewsResult _$NewsResultFromJson(Map<String, dynamic> json) {
  return _NewsResult.fromJson(json);
}

/// @nodoc
mixin _$NewsResult {
  String? get status => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;
  List<News>? get articles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsResultCopyWith<NewsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsResultCopyWith<$Res> {
  factory $NewsResultCopyWith(
          NewsResult value, $Res Function(NewsResult) then) =
      _$NewsResultCopyWithImpl<$Res, NewsResult>;
  @useResult
  $Res call({String? status, int? totalResults, List<News>? articles});
}

/// @nodoc
class _$NewsResultCopyWithImpl<$Res, $Val extends NewsResult>
    implements $NewsResultCopyWith<$Res> {
  _$NewsResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<News>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewsResultCopyWith<$Res>
    implements $NewsResultCopyWith<$Res> {
  factory _$$_NewsResultCopyWith(
          _$_NewsResult value, $Res Function(_$_NewsResult) then) =
      __$$_NewsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, int? totalResults, List<News>? articles});
}

/// @nodoc
class __$$_NewsResultCopyWithImpl<$Res>
    extends _$NewsResultCopyWithImpl<$Res, _$_NewsResult>
    implements _$$_NewsResultCopyWith<$Res> {
  __$$_NewsResultCopyWithImpl(
      _$_NewsResult _value, $Res Function(_$_NewsResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_$_NewsResult(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<News>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewsResult implements _NewsResult {
  const _$_NewsResult(
      {this.status, this.totalResults, final List<News>? articles})
      : _articles = articles;

  factory _$_NewsResult.fromJson(Map<String, dynamic> json) =>
      _$$_NewsResultFromJson(json);

  @override
  final String? status;
  @override
  final int? totalResults;
  final List<News>? _articles;
  @override
  List<News>? get articles {
    final value = _articles;
    if (value == null) return null;
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NewsResult(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewsResult &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            const DeepCollectionEquality().equals(other._articles, _articles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, totalResults,
      const DeepCollectionEquality().hash(_articles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewsResultCopyWith<_$_NewsResult> get copyWith =>
      __$$_NewsResultCopyWithImpl<_$_NewsResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewsResultToJson(
      this,
    );
  }
}

abstract class _NewsResult implements NewsResult {
  const factory _NewsResult(
      {final String? status,
      final int? totalResults,
      final List<News>? articles}) = _$_NewsResult;

  factory _NewsResult.fromJson(Map<String, dynamic> json) =
      _$_NewsResult.fromJson;

  @override
  String? get status;
  @override
  int? get totalResults;
  @override
  List<News>? get articles;
  @override
  @JsonKey(ignore: true)
  _$$_NewsResultCopyWith<_$_NewsResult> get copyWith =>
      throw _privateConstructorUsedError;
}
