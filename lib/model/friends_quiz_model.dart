import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class FriendsQuizModel {
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
}
