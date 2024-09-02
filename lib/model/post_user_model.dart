import 'package:cloud_firestore/cloud_firestore.dart';

class PostUserModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserInfo(String uid) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(uid).get();
      if (docSnapshot.exists) {
        return {
          'userName': docSnapshot.data()?['userName'] ?? '',
          'userImg': docSnapshot.data()?['userImg'] ?? '',
        };
      }
      return null;
    } catch (e) {
      print('Error getting user info from Firestore: $e');
      return null;
    }
  }
}
