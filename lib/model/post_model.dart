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
}
