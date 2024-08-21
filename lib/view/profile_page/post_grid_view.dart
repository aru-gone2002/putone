import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/item/post_grid_item.dart';
import 'package:putone/view_model/post_view_model.dart';

class PostGridView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PostViewModel postViewModel = PostViewModel();
    postViewModel.setRef(ref);
    return Padding(
      padding: const EdgeInsets.only(
        left: spaceWidthMedium,
        right: spaceWidthMedium,
        top: spaceHeightSmall,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: postGridViewCrossAxisSpacing,
          mainAxisSpacing: postGridViewMainAxisSpacing,
        ),
        itemCount: postViewModel.posts.length,
        itemBuilder: (context, index) {
          return PostGridItem(post: postViewModel.posts[index]);
        },
      ),
    );
  }
}
