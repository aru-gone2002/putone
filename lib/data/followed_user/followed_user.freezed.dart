// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'followed_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FollowedUser _$FollowedUserFromJson(Map<String, dynamic> json) {
  return _FollowedUser.fromJson(json);
}

/// @nodoc
mixin _$FollowedUser {
  String get uid => throw _privateConstructorUsedError;
  String get followedUid => throw _privateConstructorUsedError;

  /// Serializes this FollowedUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FollowedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FollowedUserCopyWith<FollowedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowedUserCopyWith<$Res> {
  factory $FollowedUserCopyWith(
          FollowedUser value, $Res Function(FollowedUser) then) =
      _$FollowedUserCopyWithImpl<$Res, FollowedUser>;
  @useResult
  $Res call({String uid, String followedUid});
}

/// @nodoc
class _$FollowedUserCopyWithImpl<$Res, $Val extends FollowedUser>
    implements $FollowedUserCopyWith<$Res> {
  _$FollowedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FollowedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? followedUid = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followedUid: null == followedUid
          ? _value.followedUid
          : followedUid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FollowedUserImplCopyWith<$Res>
    implements $FollowedUserCopyWith<$Res> {
  factory _$$FollowedUserImplCopyWith(
          _$FollowedUserImpl value, $Res Function(_$FollowedUserImpl) then) =
      __$$FollowedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String followedUid});
}

/// @nodoc
class __$$FollowedUserImplCopyWithImpl<$Res>
    extends _$FollowedUserCopyWithImpl<$Res, _$FollowedUserImpl>
    implements _$$FollowedUserImplCopyWith<$Res> {
  __$$FollowedUserImplCopyWithImpl(
      _$FollowedUserImpl _value, $Res Function(_$FollowedUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of FollowedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? followedUid = null,
  }) {
    return _then(_$FollowedUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followedUid: null == followedUid
          ? _value.followedUid
          : followedUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FollowedUserImpl with DiagnosticableTreeMixin implements _FollowedUser {
  const _$FollowedUserImpl({required this.uid, required this.followedUid});

  factory _$FollowedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FollowedUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String followedUid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FollowedUser(uid: $uid, followedUid: $followedUid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FollowedUser'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('followedUid', followedUid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowedUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.followedUid, followedUid) ||
                other.followedUid == followedUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, followedUid);

  /// Create a copy of FollowedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowedUserImplCopyWith<_$FollowedUserImpl> get copyWith =>
      __$$FollowedUserImplCopyWithImpl<_$FollowedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FollowedUserImplToJson(
      this,
    );
  }
}

abstract class _FollowedUser implements FollowedUser {
  const factory _FollowedUser(
      {required final String uid,
      required final String followedUid}) = _$FollowedUserImpl;

  factory _FollowedUser.fromJson(Map<String, dynamic> json) =
      _$FollowedUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get followedUid;

  /// Create a copy of FollowedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowedUserImplCopyWith<_$FollowedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
