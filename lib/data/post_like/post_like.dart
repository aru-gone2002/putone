import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 生成されるdartファイルの名前を指定
part 'post_like.freezed.dart';
part 'post_like.g.dart';

@freezed
class PostLike with _$PostLike {
  const factory PostLike({
    required String uid,
    required String postId,
    required String userImg,
  }) = _PostLike;
  factory PostLike.fromJson(Map<String, dynamic> json) =>
      _$PostLikeFromJson(json);
}
