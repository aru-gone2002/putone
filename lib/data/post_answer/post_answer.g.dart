// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostAnswerImpl _$$PostAnswerImplFromJson(Map<String, dynamic> json) =>
    _$PostAnswerImpl(
      replyUid: json['replyUid'] as String,
      replyUserId: json['replyUserId'] as String,
      replyUserName: json['replyUserName'] as String,
      replyUserImg: json['replyUserImg'] as String,
      answerUid: json['answerUid'] as String,
      quizChoice1Uid: json['quizChoice1Uid'] as String,
      quizChoice1UserName: json['quizChoice1UserName'] as String,
      quizChoice1UserImg: json['quizChoice1UserImg'] as String,
      quizChoice2Uid: json['quizChoice2Uid'] as String,
      quizChoice2UserName: json['quizChoice2UserName'] as String,
      quizChoice2UserImg: json['quizChoice2UserImg'] as String,
      answerTimeStamp: DateTime.parse(json['answerTimeStamp'] as String),
    );

Map<String, dynamic> _$$PostAnswerImplToJson(_$PostAnswerImpl instance) =>
    <String, dynamic>{
      'replyUid': instance.replyUid,
      'replyUserId': instance.replyUserId,
      'replyUserName': instance.replyUserName,
      'replyUserImg': instance.replyUserImg,
      'answerUid': instance.answerUid,
      'quizChoice1Uid': instance.quizChoice1Uid,
      'quizChoice1UserName': instance.quizChoice1UserName,
      'quizChoice1UserImg': instance.quizChoice1UserImg,
      'quizChoice2Uid': instance.quizChoice2Uid,
      'quizChoice2UserName': instance.quizChoice2UserName,
      'quizChoice2UserImg': instance.quizChoice2UserImg,
      'answerTimeStamp': instance.answerTimeStamp.toIso8601String(),
    };
