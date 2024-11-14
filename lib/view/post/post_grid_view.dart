import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/view/item/post_grid_item.dart';
import 'package:putone/view_model/post_view_model.dart';

class PostGridView extends ConsumerWidget {
  const PostGridView({super.key, required this.posts});

  // final AsyncSnapshot<Object> snapshot;
  final List<Post> posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var size = MediaQuery.of(context).size;
    //投稿のGridViewの横の長さを計算
    // final double postGridItemWidth =
    //     (size.width - postGridViewCrossAxisSpacing - spaceWidthMedium * 2) / 2;

    final PostViewModel postViewModel = PostViewModel();
    postViewModel.setRef(ref);
    //final localUserPosts = snapshot.data! as List<LocalUserPost>;
    //localUserPosts.sort(((a, b) => b.postTimestamp.compareTo(a.postTimestamp)));

    void onPostTap(Post post) {
      // 新しいviewへの遷移処理
      toPostListView(
          context: context, initialPostId: post.postId, posts: posts);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => PostListView(
      //       initialPostId: post.postId,
      //       uid: post.uid,
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
          // postGridItemWidth /
          //     (postGridItemWidth + postGridItemTitleSpaceHeight),
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostGridItem(
            //userPost: postViewModel.posts[index],
            userPost: post,
            onTap: () => onPostTap(post),
          );
        },
      ),
    );
  }
}
