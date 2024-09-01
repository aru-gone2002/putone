// 投稿画面にはいらないかも?(逐一いいねを監視しなければいけないので)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post_like/post_like.dart';

// PostLikeの状態を管理するProvider
final postLikeProvider = StateProvider<PostLike>(
  (ref) => PostLike(
    uid: '',
    postId: '',
    userImg: '',
  ),
);

// 特定の投稿に対するいいねを管理するProvider
final postLikesProvider = StateProvider<List<PostLike>>((ref) => []);

// 特定の投稿のいいねの状態を取得するためのProvider
final specificPostLikesProvider =
    Provider.family<List<PostLike>, String>((ref, postId) {
  final allLikes = ref.watch(postLikesProvider);
  return allLikes.where((like) => like.postId == postId).toList();
});
