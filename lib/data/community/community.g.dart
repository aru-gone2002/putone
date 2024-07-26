// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityImpl _$$CommunityImplFromJson(Map<String, dynamic> json) =>
    _$CommunityImpl(
      communityId: json['communityId'] as String,
      communityName: json['communityName'] as String,
      communityMemberUids: (json['communityMemberUids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CommunityImplToJson(_$CommunityImpl instance) =>
    <String, dynamic>{
      'communityId': instance.communityId,
      'communityName': instance.communityName,
      'communityMemberUids': instance.communityMemberUids,
    };
