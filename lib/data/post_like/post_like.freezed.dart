// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostLike _$PostLikeFromJson(Map<String, dynamic> json) {
  return _PostLike.fromJson(json);
}

/// @nodoc
mixin _$PostLike {
  String get uid => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get userImg => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;

  /// Serializes this PostLike to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostLike
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostLikeCopyWith<PostLike> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostLikeCopyWith<$Res> {
  factory $PostLikeCopyWith(PostLike value, $Res Function(PostLike) then) =
      _$PostLikeCopyWithImpl<$Res, PostLike>;
  @useResult
  $Res call({String uid, String postId, String userImg, String userName});
}

/// @nodoc
class _$PostLikeCopyWithImpl<$Res, $Val extends PostLike>
    implements $PostLikeCopyWith<$Res> {
  _$PostLikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostLike
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? postId = null,
    Object? userImg = null,
    Object? userName = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userImg: null == userImg
          ? _value.userImg
          : userImg // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostLikeImplCopyWith<$Res>
    implements $PostLikeCopyWith<$Res> {
  factory _$$PostLikeImplCopyWith(
          _$PostLikeImpl value, $Res Function(_$PostLikeImpl) then) =
      __$$PostLikeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String postId, String userImg, String userName});
}

/// @nodoc
class __$$PostLikeImplCopyWithImpl<$Res>
    extends _$PostLikeCopyWithImpl<$Res, _$PostLikeImpl>
    implements _$$PostLikeImplCopyWith<$Res> {
  __$$PostLikeImplCopyWithImpl(
      _$PostLikeImpl _value, $Res Function(_$PostLikeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostLike
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? postId = null,
    Object? userImg = null,
    Object? userName = null,
  }) {
    return _then(_$PostLikeImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userImg: null == userImg
          ? _value.userImg
          : userImg // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostLikeImpl with DiagnosticableTreeMixin implements _PostLike {
  const _$PostLikeImpl(
      {required this.uid,
      required this.postId,
      required this.userImg,
      required this.userName});

  factory _$PostLikeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostLikeImplFromJson(json);

  @override
  final String uid;
  @override
  final String postId;
  @override
  final String userImg;
  @override
  final String userName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostLike(uid: $uid, postId: $postId, userImg: $userImg, userName: $userName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostLike'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('userImg', userImg))
      ..add(DiagnosticsProperty('userName', userName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikeImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userImg, userImg) || other.userImg == userImg) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, postId, userImg, userName);

  /// Create a copy of PostLike
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikeImplCopyWith<_$PostLikeImpl> get copyWith =>
      __$$PostLikeImplCopyWithImpl<_$PostLikeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostLikeImplToJson(
      this,
    );
  }
}

abstract class _PostLike implements PostLike {
  const factory _PostLike(
      {required final String uid,
      required final String postId,
      required final String userImg,
      required final String userName}) = _$PostLikeImpl;

  factory _PostLike.fromJson(Map<String, dynamic> json) =
      _$PostLikeImpl.fromJson;

  @override
  String get uid;
  @override
  String get postId;
  @override
  String get userImg;
  @override
  String get userName;

  /// Create a copy of PostLike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostLikeImplCopyWith<_$PostLikeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
