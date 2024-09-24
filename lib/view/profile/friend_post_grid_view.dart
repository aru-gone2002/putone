import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/local_database.dart';
import 'package:putone/view/item/post_grid_item.dart';
import 'package:putone/view/module_page/post_detail_page.dart';
import 'package:putone/view/posting/post_list_view.dart';
import 'package:putone/view_model/post_view_model.dart';

class FriendPostGridView extends ConsumerWidget {
  FriendPostGridView({super.key, required this.snapshot});

  final AsyncSnapshot<List<Post>?> snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPostTap(Post post) {
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
        ),
        itemCount: (snapshot.data as List<Post>).length,
        itemBuilder: (context, index) {
          final userPost = (snapshot.data!)[index];
          return PostGridItem(
            userPost: userPost,
            onTap: () => onPostTap(userPost),
          );
        },
      ),
    );
  }
}
