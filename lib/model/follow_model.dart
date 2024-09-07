import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class FollowModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserToFollowings({
    required String uid,
  }) async {
    final myProfile = auth.currentUser;
    final Map<String, dynamic> followingUserUid = {'uid': uid};
    final response = await firestore
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
      // print('from model: ${followingUser.exists}');
      return followingUser.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getFollowingUsers({
    required String followingUid,
  }) async {
    try {
      final List<FollowingUser> followingUsers = [];
      final response = await firestore
          .collection('users')
          .doc(followingUid)
          .collection('followings')
          .get();

      if (response.docs.isEmpty) {
        return 'no-following-user';
      } else {
        //docsの中身を展開して、FollowingUser型に変換する
        for (var doc in response.docs) {
          final followingUser = FollowingUser.fromJson(doc.data());
          followingUsers.add(followingUser);
        }
        return followingUsers;
      }
    } catch (e) {
      print('Fail to get following users');
      return 'Fail to get following users';
    }
  }
}
