import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:putone/data/post_answer/post_answer.dart';

class PostAnswerModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PostAnswer>> getPostAnswers(String uid, String postId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('posts')
          .doc(postId)
          .collection('postAnswers')
          .get();

      print("Snapshot size: ${snapshot.docs.length}");

      return snapshot.docs
          .map((doc) => PostAnswer.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching post answers: $e');
      return [];
    }
  }

  Future<double> calculateCorrectAnswerPercentage(
      String uid, String postId) async {
    try {
      final answers = await getPostAnswers(uid, postId);
      if (answers.isEmpty) return 0.0;

      final correctAnswers =
          answers.where((answer) => answer.answerUid == uid).length;
      return (correctAnswers / answers.length) * 100;
    } catch (e) {
      print('Error calculating correct answer percentage: $e');
      return 0.0;
    }
  }
}
