import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class FollowModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserToFollowings({
    required String uid,
  }) async {
    final myProfile = auth.currentUser;
    final Map<String, dynamic> followingUserUid = {'uid': uid};
    await firestore
        .collection('users')
        .doc(myProfile!.uid)
        .collection('followings')
        .doc(uid)
        .set(followingUserUid);
  }

  Future<void> deleteUserFromFollowings({
    required String uid,
  }) async {
    final myProfile = auth.currentUser;
    await firestore
        .collection('users')
        .doc(myProfile!.uid)
        .collection('followings')
        .doc(uid)
        .delete();
  }

  Future<bool> isFollowingUser({
    required String uid,
  }) async {
    final myProfile = auth.currentUser;
    try {
      final followingUser = await firestore
          .collection('users')
          .doc(myProfile!.uid)
          .collection('followings')
          .doc(uid)
          .get();
      return followingUser.exists;
    } catch (e) {
      rethrow;
    }
  }
}
