import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/local_database.dart';
import 'package:putone/model/friends_quiz_model.dart';
import 'package:putone/providers/friends_quiz_provider.dart';

class FriendsQuizViewModel {
  final FriendsQuizModel _friendsQuizModel = FriendsQuizModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<PostAnswer> get postAnswers => _ref.watch(postAnswersProvider);

  void savePostAnswers(List<PostAnswer> value) {
    _ref.read(postAnswersProvider.notifier).state = value;
  }

  void addPostAnswers(PostAnswer value) {
    _ref.read(postAnswersProvider.notifier).state = [...postAnswers, value];
  }

  void resetPostAnswers() {
    _ref.read(postAnswersProvider.notifier).state = [];
  }

  Future<UserProfile?> getQuizUserProfile(String uid) async {
    final result = await _friendsQuizModel.getQuizUserProfile(uid);
    return result;
  }

  Future<void> sendPostAnswerToFirestore(
      {required PostAnswer postAnswer}) async {
    // addPostAnswers(postAnswer);
    await _friendsQuizModel.sendPostAnswerToFirestore(postAnswer: postAnswer);
  }

  Future<void> getAllPostAnswersFromFirestore() async {
    final result = await _friendsQuizModel.getAllPostAnswersFromFirestore();
    if (result != null) {
      savePostAnswers(result);
    } else {
      Fluttertoast.showToast(msg: '投稿への回答を取得中にエラーが発生しました');
    }
  }

  List<PostAnswer> changeLocalUserPostAnswerstoPostAnswers(
      List<LocalUserPostAnswer> localUserPostAnswers) {
    final List<PostAnswer> userPostAnswers = [];
    for (var localUserPostAnswer in localUserPostAnswers) {
      final postAnswer = PostAnswer(
          postId: localUserPostAnswer.postId,
          posterUid: localUserPostAnswer.posterUid,
          posterUserName: localUserPostAnswer.posterUserName,
          posterUserImg: localUserPostAnswer.posterUserImg,
          replyUid: localUserPostAnswer.replyUid,
          replyUserId: localUserPostAnswer.replyUserId,
          replyUserName: localUserPostAnswer.replyUserName,
          replyUserImg: localUserPostAnswer.replyUserImg,
          answerUid: localUserPostAnswer.answerUid,
          quizChoice1Uid: localUserPostAnswer.quizChoice1Uid,
          quizChoice1UserName: localUserPostAnswer.quizChoice1UserName,
          quizChoice1UserImg: localUserPostAnswer.quizChoice1UserImg,
          quizChoice2Uid: localUserPostAnswer.quizChoice2Uid,
          quizChoice2UserName: localUserPostAnswer.quizChoice2UserName,
          quizChoice2UserImg: localUserPostAnswer.quizChoice2UserImg,
          answerTimestamp: localUserPostAnswer.answerTimestamp);
      userPostAnswers.add(postAnswer);
    }
    return userPostAnswers;
  }
}
