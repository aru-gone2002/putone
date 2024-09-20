import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 生成されるdartファイルの名前を指定
part 'post_answer.freezed.dart';
part 'post_answer.g.dart';

@freezed
class PostAnswer with _$PostAnswer {
  const factory PostAnswer({
    required String replyUid,
    required String replyUserId,
    required String replyUserName,
    required String replyUserImg,
    required String answerUid,
    required String posterUid,
    required String quizChoice1Uid,
    required String quizChoice1UserName,
    required String quizChoice1UserImg,
    required String quizChoice2Uid,
    required String quizChoice2UserName,
    required String quizChoice2UserImg,
    required DateTime answerTimeStamp,
  }) = _PostAnswer;
  factory PostAnswer.fromJson(Map<String, dynamic> json) =>
      _$PostAnswerFromJson(json);
}
