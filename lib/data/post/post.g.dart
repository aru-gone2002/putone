// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      postMusicImg: json['postMusicImg'] as String,
      postMusicArtistName: json['postMusicArtistName'] as String,
      postMusicName: json['postMusicName'] as String,
      postMsg: json['postMsg'] as String,
      postTimestamp: DateTime.parse(json['postTimestamp'] as String),
      postMusicSpotifyUrl: json['postMusicSpotifyUrl'] as String,
      postMusicPreviewUrl: json['postMusicPreviewUrl'] as String,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'postId': instance.postId,
      'postMusicImg': instance.postMusicImg,
      'postMusicArtistName': instance.postMusicArtistName,
      'postMusicName': instance.postMusicName,
      'postMsg': instance.postMsg,
      'postTimestamp': instance.postTimestamp.toIso8601String(),
      'postMusicSpotifyUrl': instance.postMusicSpotifyUrl,
      'postMusicPreviewUrl': instance.postMusicPreviewUrl,
    };
