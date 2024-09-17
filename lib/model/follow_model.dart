import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class FollowModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserToFollowings({
    required FollowingUser followingUser,
  }) async {
    final uid = auth.currentUser!.uid;
    final Map<String, dynamic> followingUserMap = followingUser.toJson();
    await firestore
        .collection('users')
        .doc(uid)
        .collection('followings')
        .doc(followingUser.followingUid)
        .set(followingUserMap);
  }

  Future<void> deleteUserFromFollowings({
    required String followingUid,
  }) async {
    final uid = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(uid)
        .collection('followings')
        .doc(followingUid)
        .delete();
  }

  Future<bool> isFollowingUser({
    required String followingUid,
  }) async {
    try {
      final uid = auth.currentUser!.uid;
      final followingUser = await firestore
          .collection('users')
          .doc(uid)
          .collection('followings')
          .doc(followingUid)
          .get();
      // print('from model: ${followingUser.exists}');
      return followingUser.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getFollowingUsers() async {
    try {
      final List<FollowingUser> followingUsers = [];
      final uid = auth.currentUser!.uid;
      final response = await firestore
          .collection('users')
          .doc(uid)
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
