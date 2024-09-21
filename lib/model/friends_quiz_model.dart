import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class FriendsQuizModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserProfile?> getQuizUserProfile(String uid) async {
    try {
      final response = await firestore.collection('users').doc(uid).get();
      final responseData = response.data() as Map<String, dynamic>;
      final userProfile = UserProfile.fromJson(responseData);
      return userProfile;
    } catch (e) {
      print('Error getting userProfile from Firestore: $e');
      return null;
    }
  }

  Future<void> sendPostAnswerToFirestore(
      {required PostAnswer postAnswer}) async {
    try {
      await firestore
          .collection('users')
          .doc(postAnswer.posterUid)
          .collection('posts')
          .doc(postAnswer.postId)
          .collection('postAnswers')
          .doc(postAnswer.replyUid)
          .set(postAnswer.toJson());
    } catch (e) {
      print('Error sending postAnswer to Firestore: $e');
    }
  }

  Future<List<PostAnswer>?> getAllPostAnswersFromFirestore() async {
    final uid = auth.currentUser!.uid;
    final List<PostAnswer> postAnswers = [];
    try {
      // 複数のコレクションから取得しなければならない
      // コレクショングループから取得する
      final response = await firestore
          .collectionGroup('postAnswers')
          .where('replyUid', isEqualTo: uid)
          .get();
      if (response.docs.isEmpty) {
        return [];
      } else {
        for (var docSnapshot in response.docs) {
          final postAnswer = PostAnswer.fromJson(docSnapshot.data());
          postAnswers.add(postAnswer);
        }
        return postAnswers;
      }
    } catch (e) {
      print('Error getting postAnswers from Firestore: $e');
      return null;
    }
  }
}
