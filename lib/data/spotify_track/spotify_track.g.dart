// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotifyTrackImpl _$$SpotifyTrackImplFromJson(Map<String, dynamic> json) =>
    _$SpotifyTrackImpl(
      trackImg: json['trackImg'] as String,
      artistName: json['artistName'] as String,
      trackName: json['trackName'] as String,
      trackExternalUrl: json['trackExternalUrl'] as String,
      previewUrl: json['previewUrl'] as String?,
    );

Map<String, dynamic> _$$SpotifyTrackImplToJson(_$SpotifyTrackImpl instance) =>
    <String, dynamic>{
      'trackImg': instance.trackImg,
      'artistName': instance.artistName,
      'trackName': instance.trackName,
      'trackExternalUrl': instance.trackExternalUrl,
      'previewUrl': instance.previewUrl,
    };
