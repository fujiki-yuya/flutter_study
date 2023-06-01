// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pull.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pull _$PullFromJson(Map<String, dynamic> json) {
  return _Pull.fromJson(json);
}

/// @nodoc
mixin _$Pull {
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PullCopyWith<Pull> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PullCopyWith<$Res> {
  factory $PullCopyWith(Pull value, $Res Function(Pull) then) =
      _$PullCopyWithImpl<$Res, Pull>;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$PullCopyWithImpl<$Res, $Val extends Pull>
    implements $PullCopyWith<$Res> {
  _$PullCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PullCopyWith<$Res> implements $PullCopyWith<$Res> {
  factory _$$_PullCopyWith(_$_Pull value, $Res Function(_$_Pull) then) =
      __$$_PullCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$$_PullCopyWithImpl<$Res> extends _$PullCopyWithImpl<$Res, _$_Pull>
    implements _$$_PullCopyWith<$Res> {
  __$$_PullCopyWithImpl(_$_Pull _value, $Res Function(_$_Pull) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$_Pull(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pull implements _Pull {
  const _$_Pull({this.title});

  factory _$_Pull.fromJson(Map<String, dynamic> json) => _$$_PullFromJson(json);

  @override
  final String? title;

  @override
  String toString() {
    return 'Pull(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pull &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PullCopyWith<_$_Pull> get copyWith =>
      __$$_PullCopyWithImpl<_$_Pull>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PullToJson(
      this,
    );
  }
}

abstract class _Pull implements Pull {
  const factory _Pull({final String? title}) = _$_Pull;

  factory _Pull.fromJson(Map<String, dynamic> json) = _$_Pull.fromJson;

  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_PullCopyWith<_$_Pull> get copyWith => throw _privateConstructorUsedError;
}
