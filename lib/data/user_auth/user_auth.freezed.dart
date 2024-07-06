// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) {
  return _UserAuth.fromJson(json);
}

/// @nodoc
mixin _$UserAuth {
  String get uid => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  String get userPassword => throw _privateConstructorUsedError;
  bool get userEmailVerified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAuthCopyWith<UserAuth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthCopyWith<$Res> {
  factory $UserAuthCopyWith(UserAuth value, $Res Function(UserAuth) then) =
      _$UserAuthCopyWithImpl<$Res, UserAuth>;
  @useResult
  $Res call(
      {String uid,
      String userEmail,
      String userPassword,
      bool userEmailVerified});
}

/// @nodoc
class _$UserAuthCopyWithImpl<$Res, $Val extends UserAuth>
    implements $UserAuthCopyWith<$Res> {
  _$UserAuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? userEmail = null,
    Object? userPassword = null,
    Object? userEmailVerified = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: null == userPassword
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userEmailVerified: null == userEmailVerified
          ? _value.userEmailVerified
          : userEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAuthImplCopyWith<$Res>
    implements $UserAuthCopyWith<$Res> {
  factory _$$UserAuthImplCopyWith(
          _$UserAuthImpl value, $Res Function(_$UserAuthImpl) then) =
      __$$UserAuthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String userEmail,
      String userPassword,
      bool userEmailVerified});
}

/// @nodoc
class __$$UserAuthImplCopyWithImpl<$Res>
    extends _$UserAuthCopyWithImpl<$Res, _$UserAuthImpl>
    implements _$$UserAuthImplCopyWith<$Res> {
  __$$UserAuthImplCopyWithImpl(
      _$UserAuthImpl _value, $Res Function(_$UserAuthImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? userEmail = null,
    Object? userPassword = null,
    Object? userEmailVerified = null,
  }) {
    return _then(_$UserAuthImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: null == userPassword
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userEmailVerified: null == userEmailVerified
          ? _value.userEmailVerified
          : userEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAuthImpl with DiagnosticableTreeMixin implements _UserAuth {
  const _$UserAuthImpl(
      {required this.uid,
      required this.userEmail,
      required this.userPassword,
      required this.userEmailVerified});

  factory _$UserAuthImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAuthImplFromJson(json);

  @override
  final String uid;
  @override
  final String userEmail;
  @override
  final String userPassword;
  @override
  final bool userEmailVerified;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserAuth(uid: $uid, userEmail: $userEmail, userPassword: $userPassword, userEmailVerified: $userEmailVerified)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserAuth'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('userEmail', userEmail))
      ..add(DiagnosticsProperty('userPassword', userPassword))
      ..add(DiagnosticsProperty('userEmailVerified', userEmailVerified));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userPassword, userPassword) ||
                other.userPassword == userPassword) &&
            (identical(other.userEmailVerified, userEmailVerified) ||
                other.userEmailVerified == userEmailVerified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, userEmail, userPassword, userEmailVerified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAuthImplCopyWith<_$UserAuthImpl> get copyWith =>
      __$$UserAuthImplCopyWithImpl<_$UserAuthImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAuthImplToJson(
      this,
    );
  }
}

abstract class _UserAuth implements UserAuth {
  const factory _UserAuth(
      {required final String uid,
      required final String userEmail,
      required final String userPassword,
      required final bool userEmailVerified}) = _$UserAuthImpl;

  factory _UserAuth.fromJson(Map<String, dynamic> json) =
      _$UserAuthImpl.fromJson;

  @override
  String get uid;
  @override
  String get userEmail;
  @override
  String get userPassword;
  @override
  bool get userEmailVerified;
  @override
  @JsonKey(ignore: true)
  _$$UserAuthImplCopyWith<_$UserAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
