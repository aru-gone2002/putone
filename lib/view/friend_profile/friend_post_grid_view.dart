import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/view/item/post_grid_item.dart';
import 'package:putone/view/post/post_list_view.dart';

class FriendPostGridView extends ConsumerWidget {
  const FriendPostGridView({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPostTap(Post post) {
      final initialIndex =
          posts.indexWhere((element) => element.postId == post.postId);
      toPostListView(
          context: context, initialIndex: initialIndex, posts: posts);
      // 新しいviewへの遷移処理
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => PostListView(
      //       initialPostId: post.postId,
      //       posts: posts,
      //     ),
      //   ),
      // );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: postGridPaddingWidth,
        right: postGridPaddingWidth,
        top: postGridPaddingHeight,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: postGridViewCrossAxisSpacing,
          mainAxisSpacing: postGridViewMainAxisSpacing,
          childAspectRatio: 1,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final userPost = posts[index];
          return PostGridItem(
            userPost: userPost,
            onTap: () => onPostTap(userPost),
          );
        },
      ),
    );
  }
}
