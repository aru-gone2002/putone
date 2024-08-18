// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      uid: json['uid'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImg: json['userImg'] as String,
      themeMusicImg: json['themeMusicImg'] as String,
      themeMusicArtistName: json['themeMusicArtistName'] as String,
      themeMusicName: json['themeMusicName'] as String,
      themeMusicSpotifyUrl: json['themeMusicSpotifyUrl'] as String,
      themeMusicPreviewUrl: json['themeMusicPreviewUrl'] as String,
      userProfileMsg: json['userProfileMsg'] as String,
      userSpotifyConnected: json['userSpotifyConnected'] as bool,
      userSignUpTimestamp:
          DateTime.parse(json['userSignUpTimestamp'] as String),
      userLastLoginTimestamp:
          DateTime.parse(json['userLastLoginTimestamp'] as String),
      communityId: json['communityId'] as String,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImg': instance.userImg,
      'themeMusicImg': instance.themeMusicImg,
      'themeMusicArtistName': instance.themeMusicArtistName,
      'themeMusicName': instance.themeMusicName,
      'themeMusicSpotifyUrl': instance.themeMusicSpotifyUrl,
      'themeMusicPreviewUrl': instance.themeMusicPreviewUrl,
      'userProfileMsg': instance.userProfileMsg,
      'userSpotifyConnected': instance.userSpotifyConnected,
      'userSignUpTimestamp': instance.userSignUpTimestamp.toIso8601String(),
      'userLastLoginTimestamp':
          instance.userLastLoginTimestamp.toIso8601String(),
      'communityId': instance.communityId,
    };
