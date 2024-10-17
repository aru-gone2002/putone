import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/view/module_page/post_card.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class MyQuizPage extends ConsumerWidget {
  const MyQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final PostViewModel postViewModel = PostViewModel();
    profileViewModel.setRef(ref);
    postViewModel.setRef(ref);

    final uid = profileViewModel.uid;
    final userImg = profileViewModel.userImg;
    final userName = profileViewModel.userName;
    final posts = postViewModel.posts;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
            post: post, uid: uid, userImg: userImg, userName: userName);
      },
    );
    //   },
    // ),
    // );
  }
}
