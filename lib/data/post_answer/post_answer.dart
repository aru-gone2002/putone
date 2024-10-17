// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'post_answer.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'post_answer.g.dart';

@freezed
class PostAnswer with _$PostAnswer {
  const factory PostAnswer({
    required String postId,
    required String posterUid,
    required String posterUserName,
    required String posterUserImg,
    required String replyUid,
    required String replyUserId,
    required String replyUserName,
    required String replyUserImg,
    required String answerUid,
    required String quizChoice1Uid,
    required String quizChoice1UserName,
    required String quizChoice1UserImg,
    required String quizChoice2Uid,
    required String quizChoice2UserName,
    required String quizChoice2UserImg,
    required DateTime answerTimestamp,
  }) = _PostAnswer;

  factory PostAnswer.fromJson(Map<String, Object?> json) =>
      _$PostAnswerFromJson(json);
}
