import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/post/post.dart';

class PostModel {
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
          .get();
      for (var docSnapshot in response.docs) {
        //docSnapshot.data()を一つずつproviderに格納していく
        //①一回変数に全て入れて、それを返り値として返してから、providerに入れる。
        final userPost = Post.fromJson(docSnapshot.data());
        userPosts.add(userPost);
      }
      userPosts.sort((a, b) => a.postTimestamp.compareTo(b.postTimestamp));
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
}
