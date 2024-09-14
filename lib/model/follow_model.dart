import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:putone/data/followed_user/followed_user.dart';
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

  Future<int> getFollowingNum() async {
    try {
      final List<FollowingUser> followingUsers = [];
      final uid = auth.currentUser!.uid;
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('followings')
          .get();

      if (response.docs.isEmpty) {
        return 0;
      } else {
        //docsの中身を展開して、FollowingUser型に変換する
        for (var doc in response.docs) {
          final followingUser = FollowingUser.fromJson(doc.data());
          followingUsers.add(followingUser);
        }
        return followingUsers.length;
      }
    } catch (e) {
      print('Fail to get following user number.');
      return 0;
    }
  }

  Future<void> addSelfToFriendsFollowers({
    required String friendsUid,
  }) async {
    final myUid = auth.currentUser!.uid;
    FollowedUser followedUser = FollowedUser(
      uid: friendsUid,
      followedUid: myUid,
    );
    final Map<String, dynamic> followedUserMap = followedUser.toJson();
    await firestore
        .collection('users')
        .doc(friendsUid)
        .collection('followers')
        .doc(myUid)
        .set(followedUserMap);
  }

  Future<void> deleteSelfFromFriendsFollowers({
    required String friendsUid,
  }) async {
    final myUid = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(friendsUid)
        .collection('followers')
        .doc(myUid)
        .delete();
  }

  Future<dynamic> getFollowedUsers(String uid) async {
    try {
      final List<FollowedUser> followedUsers = [];
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('followers')
          .get();

      if (response.docs.isEmpty) {
        return 'no-followers';
      } else {
        //docsの中身を展開して、FollowingUser型に変換する
        for (var doc in response.docs) {
          final followedUser = FollowedUser.fromJson(doc.data());
          followedUsers.add(followedUser);
        }
        return followedUsers;
      }
    } catch (e) {
      print('Fail to get followed users');
      return 'Fail to get followed users';
    }
  }
}
