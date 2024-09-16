// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostAnswerImpl _$$PostAnswerImplFromJson(Map<String, dynamic> json) =>
    _$PostAnswerImpl(
      replyUid: json['replyUid'] as String,
      replyUserId: json['replyUserId'] as String,
      answerUid: json['answerUid'] as String,
      quizChoice1Uid: json['quizChoice1Uid'] as String,
      quizChoice1UserName: json['quizChoice1UserName'] as String,
      quizChoice2Uid: json['quizChoice2Uid'] as String,
      quizChoice2UserName: json['quizChoice2UserName'] as String,
      answerTimeStamp: DateTime.parse(json['answerTimeStamp'] as String),
    );

Map<String, dynamic> _$$PostAnswerImplToJson(_$PostAnswerImpl instance) =>
    <String, dynamic>{
      'replyUid': instance.replyUid,
      'replyUserId': instance.replyUserId,
      'answerUid': instance.answerUid,
      'quizChoice1Uid': instance.quizChoice1Uid,
      'quizChoice1UserName': instance.quizChoice1UserName,
      'quizChoice2Uid': instance.quizChoice2Uid,
      'quizChoice2UserName': instance.quizChoice2UserName,
      'answerTimeStamp': instance.answerTimeStamp.toIso8601String(),
    };
