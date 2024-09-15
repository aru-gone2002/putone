import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/local_database.dart';
import 'package:putone/view/item/post_grid_item.dart';
import 'package:putone/view/module_page/post_detail_page.dart';
import 'package:putone/view/posting/post_list_view.dart';
import 'package:putone/view_model/post_view_model.dart';

class PostGridView extends ConsumerWidget {
  const PostGridView({super.key, required this.snapshot});

  final AsyncSnapshot<Object> snapshot;

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

    void onPostTap(LocalUserPost post) {
      // 新しいviewへの遷移処理
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostListView(
            initialPostId: post.postId,
            uid: post.uid,
          ),
        ),
      );
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
        itemCount: (snapshot.data as List<LocalUserPost>).length,
        itemBuilder: (context, index) {
          final localUserPost = (snapshot.data! as List<LocalUserPost>)[index];
          return PostGridItem(
            //userPost: postViewModel.posts[index],
            localUserPost: localUserPost,
            onTap: () => onPostTap(localUserPost),
          );
        },
      ),
    );
  }
}
