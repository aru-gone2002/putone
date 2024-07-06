// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAuthImpl _$$UserAuthImplFromJson(Map<String, dynamic> json) =>
    _$UserAuthImpl(
      uid: json['uid'] as String,
      userEmail: json['userEmail'] as String,
      userPassword: json['userPassword'] as String,
      userEmailVerified: json['userEmailVerified'] as bool,
    );

Map<String, dynamic> _$$UserAuthImplToJson(_$UserAuthImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userEmailVerified': instance.userEmailVerified,
    };
