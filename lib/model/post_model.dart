import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/constants/enums.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/post/post.dart';

class PostModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadNewPost({required Post post}) async {
    final postMap = post.toJson();
    await firestore
        .collection('users')
        .doc(post.uid)
        .collection('posts')
        .doc(post.postId)
        .set(postMap);
  }

  Future<dynamic> getUserPosts(String uid) async {
    final List<Post> userPosts = [];
    try {
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('posts')
          .orderBy('postTimestamp', descending: false)
          .get();
      for (var docSnapshot in response.docs) {
        //docSnapshot.data()を一つずつproviderに格納していく
        //①一回変数に全て入れて、それを返り値として返してから、providerに入れる。
        final userPost = Post.fromJson(docSnapshot.data());
        userPosts.add(userPost);
      }
      return userPosts;
    } catch (e) {
      print('Error getting userPosts from Firestore: $e');
    }
  }

  Future<List<Post>> getPosterPostsByTime(String uid) async {
    final List<Post> posterPosts = [];
    try {
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('posts')
          .orderBy('postTimestamp', descending: true) // 降順でソート
          .get();
      for (var docSnapshot in response.docs) {
        final posterPost = Post.fromJson(docSnapshot.data());
        posterPosts.add(posterPost);
      }
      return posterPosts;
    } catch (e) {
      print('Error getting userPosts from Firestore: $e');
      return [];
    }
  }

  Future<dynamic> getFollowingUsersPosts() async {
    final uid = auth.currentUser!.uid;
    final List<String> followingUids = [];
    final List<Post> followingUsersPosts = [];

    try {
      final followingUsersQuerySnap = await firestore
          .collection('users')
          .doc(uid)
          .collection('followings')
          .where('followingUid', isNotEqualTo: uid)
          .get();

      //followingUsersQuerySnapがEmptyのことも考える
      //ここの処理を書く
      if (followingUsersQuerySnap.docs.isEmpty ||
          followingUsersQuerySnap.docs.length <= 2) {
        return GetFollowingUsersPostsCondition.lackOfFriends;
      }
      //docsからuidを取得する
      for (var docSnap in followingUsersQuerySnap.docs) {
        final followingUser = FollowingUser.fromJson(docSnap.data());
        followingUids.add(followingUser.followingUid);
      }
      //取得したuidの投稿を取得する
      //トランザクションを用いて処理を書く
      for (var followingUid in followingUids) {
        final followingUsersPostsQuerySnap = await firestore
            .collection('users')
            .doc(followingUid)
            .collection('posts')
            .get();
        if (followingUsersPostsQuerySnap.docs.isNotEmpty) {
          for (var docSnap in followingUsersPostsQuerySnap.docs) {
            final followingUserPost = Post.fromJson(docSnap.data());
            followingUsersPosts.add(followingUserPost);
          }
        } else {
          return GetFollowingUsersPostsCondition.noPost;
        }
      }
      //followingUsersPostsをpostTimestampで並べ替え
      followingUsersPosts
          .sort((a, b) => b.postTimestamp.compareTo(a.postTimestamp));
      print('followingUsersPost: $followingUsersPosts');
      return followingUsersPosts;
    } catch (e) {
      print('Error getting following user posts from Firestore: $e');
      return null;
    }
  }
}
