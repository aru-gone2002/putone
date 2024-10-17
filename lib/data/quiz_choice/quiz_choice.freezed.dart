// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_choice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuizChoice _$QuizChoiceFromJson(Map<String, dynamic> json) {
  return _QuizChoice.fromJson(json);
}

/// @nodoc
mixin _$QuizChoice {
  String get quizChoiceUid => throw _privateConstructorUsedError;
  String get quizChoiceUserName => throw _privateConstructorUsedError;
  String get quizChoiceUserImg => throw _privateConstructorUsedError;

  /// Serializes this QuizChoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizChoiceCopyWith<QuizChoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizChoiceCopyWith<$Res> {
  factory $QuizChoiceCopyWith(
          QuizChoice value, $Res Function(QuizChoice) then) =
      _$QuizChoiceCopyWithImpl<$Res, QuizChoice>;
  @useResult
  $Res call(
      {String quizChoiceUid,
      String quizChoiceUserName,
      String quizChoiceUserImg});
}

/// @nodoc
class _$QuizChoiceCopyWithImpl<$Res, $Val extends QuizChoice>
    implements $QuizChoiceCopyWith<$Res> {
  _$QuizChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizChoiceUid = null,
    Object? quizChoiceUserName = null,
    Object? quizChoiceUserImg = null,
  }) {
    return _then(_value.copyWith(
      quizChoiceUid: null == quizChoiceUid
          ? _value.quizChoiceUid
          : quizChoiceUid // ignore: cast_nullable_to_non_nullable
              as String,
      quizChoiceUserName: null == quizChoiceUserName
          ? _value.quizChoiceUserName
          : quizChoiceUserName // ignore: cast_nullable_to_non_nullable
              as String,
      quizChoiceUserImg: null == quizChoiceUserImg
          ? _value.quizChoiceUserImg
          : quizChoiceUserImg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizChoiceImplCopyWith<$Res>
    implements $QuizChoiceCopyWith<$Res> {
  factory _$$QuizChoiceImplCopyWith(
          _$QuizChoiceImpl value, $Res Function(_$QuizChoiceImpl) then) =
      __$$QuizChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String quizChoiceUid,
      String quizChoiceUserName,
      String quizChoiceUserImg});
}

/// @nodoc
class __$$QuizChoiceImplCopyWithImpl<$Res>
    extends _$QuizChoiceCopyWithImpl<$Res, _$QuizChoiceImpl>
    implements _$$QuizChoiceImplCopyWith<$Res> {
  __$$QuizChoiceImplCopyWithImpl(
      _$QuizChoiceImpl _value, $Res Function(_$QuizChoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizChoiceUid = null,
    Object? quizChoiceUserName = null,
    Object? quizChoiceUserImg = null,
  }) {
    return _then(_$QuizChoiceImpl(
      quizChoiceUid: null == quizChoiceUid
          ? _value.quizChoiceUid
          : quizChoiceUid // ignore: cast_nullable_to_non_nullable
              as String,
      quizChoiceUserName: null == quizChoiceUserName
          ? _value.quizChoiceUserName
          : quizChoiceUserName // ignore: cast_nullable_to_non_nullable
              as String,
      quizChoiceUserImg: null == quizChoiceUserImg
          ? _value.quizChoiceUserImg
          : quizChoiceUserImg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizChoiceImpl implements _QuizChoice {
  const _$QuizChoiceImpl(
      {required this.quizChoiceUid,
      required this.quizChoiceUserName,
      required this.quizChoiceUserImg});

  factory _$QuizChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizChoiceImplFromJson(json);

  @override
  final String quizChoiceUid;
  @override
  final String quizChoiceUserName;
  @override
  final String quizChoiceUserImg;

  @override
  String toString() {
    return 'QuizChoice(quizChoiceUid: $quizChoiceUid, quizChoiceUserName: $quizChoiceUserName, quizChoiceUserImg: $quizChoiceUserImg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizChoiceImpl &&
            (identical(other.quizChoiceUid, quizChoiceUid) ||
                other.quizChoiceUid == quizChoiceUid) &&
            (identical(other.quizChoiceUserName, quizChoiceUserName) ||
                other.quizChoiceUserName == quizChoiceUserName) &&
            (identical(other.quizChoiceUserImg, quizChoiceUserImg) ||
                other.quizChoiceUserImg == quizChoiceUserImg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, quizChoiceUid, quizChoiceUserName, quizChoiceUserImg);

  /// Create a copy of QuizChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizChoiceImplCopyWith<_$QuizChoiceImpl> get copyWith =>
      __$$QuizChoiceImplCopyWithImpl<_$QuizChoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizChoiceImplToJson(
      this,
    );
  }
}

abstract class _QuizChoice implements QuizChoice {
  const factory _QuizChoice(
      {required final String quizChoiceUid,
      required final String quizChoiceUserName,
      required final String quizChoiceUserImg}) = _$QuizChoiceImpl;

  factory _QuizChoice.fromJson(Map<String, dynamic> json) =
      _$QuizChoiceImpl.fromJson;

  @override
  String get quizChoiceUid;
  @override
  String get quizChoiceUserName;
  @override
  String get quizChoiceUserImg;

  /// Create a copy of QuizChoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizChoiceImplCopyWith<_$QuizChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
