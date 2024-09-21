import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:putone/data/post_answer/post_answer.dart';

class PostAnswerModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PostAnswer>> getPostAnswersStream(String uid, String postId) {
    // デバッグ出力
    print("Fetching post answers for uid: $uid, postId: $postId");

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .collection('postAnswers')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        print("No post answers found for this post.");
        return [];
      }
      print("Snapshot size: ${snapshot.docs.length}");

      return snapshot.docs
          .map((doc) => PostAnswer.fromJson(doc.data()))
          .toList();
    });
  }

  // Stream<double> calculateCorrectAnswerPercentageStream(
  //     String uid, String postId) {
  //   return getPostAnswersStream(uid, postId).map((answers) {
  //     if (answers.isEmpty) return 0.0;

  //     final correctAnswers =
  //         answers.where((answer) => answer.answerUid == uid).length;
  //     return (correctAnswers / answers.length) * 100;
  //   });
  // }
  Stream<double> calculateCorrectAnswerPercentageStream(
      String uid, String postId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .collection('postAnswers')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        print("No post answers found for percentage calculation.");
        return 0.0;
      }

      final totalAnswers = snapshot.docs.length;
      final correctAnswers = snapshot.docs.where((doc) {
        final answerUid = doc.data()['answerUid'];
        print("Answer UID: $answerUid, Correct UID: $uid");
        return answerUid == uid;
      }).length;

      final percentage = (correctAnswers / totalAnswers) * 100;
      print("Calculated percentage: $percentage");
      return percentage;
    });
  }
}
