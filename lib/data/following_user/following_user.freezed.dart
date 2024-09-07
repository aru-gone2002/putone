// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'following_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FollowingUser _$FollowingUserFromJson(Map<String, dynamic> json) {
  return _FollowingUser.fromJson(json);
}

/// @nodoc
mixin _$FollowingUser {
  String get uid => throw _privateConstructorUsedError;
  String get followingUserId => throw _privateConstructorUsedError;

  /// Serializes this FollowingUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FollowingUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FollowingUserCopyWith<FollowingUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowingUserCopyWith<$Res> {
  factory $FollowingUserCopyWith(
          FollowingUser value, $Res Function(FollowingUser) then) =
      _$FollowingUserCopyWithImpl<$Res, FollowingUser>;
  @useResult
  $Res call({String uid, String followingUserId});
}

/// @nodoc
class _$FollowingUserCopyWithImpl<$Res, $Val extends FollowingUser>
    implements $FollowingUserCopyWith<$Res> {
  _$FollowingUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FollowingUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? followingUserId = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followingUserId: null == followingUserId
          ? _value.followingUserId
          : followingUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FollowingUserImplCopyWith<$Res>
    implements $FollowingUserCopyWith<$Res> {
  factory _$$FollowingUserImplCopyWith(
          _$FollowingUserImpl value, $Res Function(_$FollowingUserImpl) then) =
      __$$FollowingUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String followingUserId});
}

/// @nodoc
class __$$FollowingUserImplCopyWithImpl<$Res>
    extends _$FollowingUserCopyWithImpl<$Res, _$FollowingUserImpl>
    implements _$$FollowingUserImplCopyWith<$Res> {
  __$$FollowingUserImplCopyWithImpl(
      _$FollowingUserImpl _value, $Res Function(_$FollowingUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of FollowingUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? followingUserId = null,
  }) {
    return _then(_$FollowingUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followingUserId: null == followingUserId
          ? _value.followingUserId
          : followingUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FollowingUserImpl
    with DiagnosticableTreeMixin
    implements _FollowingUser {
  const _$FollowingUserImpl({required this.uid, required this.followingUserId});

  factory _$FollowingUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FollowingUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String followingUserId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FollowingUser(uid: $uid, followingUserId: $followingUserId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FollowingUser'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('followingUserId', followingUserId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowingUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.followingUserId, followingUserId) ||
                other.followingUserId == followingUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, followingUserId);

  /// Create a copy of FollowingUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowingUserImplCopyWith<_$FollowingUserImpl> get copyWith =>
      __$$FollowingUserImplCopyWithImpl<_$FollowingUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FollowingUserImplToJson(
      this,
    );
  }
}

abstract class _FollowingUser implements FollowingUser {
  const factory _FollowingUser(
      {required final String uid,
      required final String followingUserId}) = _$FollowingUserImpl;

  factory _FollowingUser.fromJson(Map<String, dynamic> json) =
      _$FollowingUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get followingUserId;

  /// Create a copy of FollowingUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowingUserImplCopyWith<_$FollowingUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
