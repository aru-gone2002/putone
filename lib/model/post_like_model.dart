import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_like/post_like.dart';

class PostLikeModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 投稿に対していいねを追加/既にいいねしている場合は削除
  Future<void> updateLike(
      String postId, String posterUid, String senderUid, String userImg) async {
    final postLikeRef = _firestore
        .collection('users')
        .doc(posterUid)
        .collection('posts')
        .doc(postId)
        .collection('post_like');
    final likeMap = {
      'uid': senderUid,
      'userImg': userImg,
      'postId': postId,
    };
    await _firestore.runTransaction((transaction) async {
      if (await postLikeRef.doc(senderUid).get().then((doc) => doc.exists)) {
        // 投稿が見つかれば削除
        await postLikeRef.doc(senderUid).delete();
      } else {
        // 投稿が見つからなければ追加
        await postLikeRef.doc(senderUid).set(likeMap);
      }
    });
  }

  // 投稿に対していいね一覧を取得
  Stream<List<PostLike>> getPostLikeList(String postId, String posterUid) {
    final postLikeRef = _firestore
        .collection('users')
        .doc(posterUid)
        .collection('posts')
        .doc(postId)
        .collection('post_like');
    return postLikeRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostLike(
          uid: doc['uid'],
          userImg: doc['userImg'],
          postId: doc['postId'],
        );
      }).toList();
    });
  }

  // 投稿のいいね数を取得
  Stream<int> getPostLikeCount(String postId, String posterUid) {
    final postLikeRef = _firestore
        .collection('users')
        .doc(posterUid)
        .collection('posts')
        .doc(postId)
        .collection('post_like');
    return postLikeRef.snapshots().map((snapshot) {
      return snapshot.docs.length;
    });
  }

  // 投稿に対して自分がいいねしているかどうかを取得
  Stream<bool> hasUserLiked(String postId, String posterUid, String userId) {
    final postLikeRef = _firestore
        .collection('users')
        .doc(posterUid)
        .collection('posts')
        .doc(postId)
        .collection('post_like')
        .doc(userId);
    return postLikeRef.snapshots().map((snapshot) => snapshot.exists);
  }
}
