import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/quiz_item.dart';
import 'package:putone/view_model/post_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PostViewModel _postViewModel = PostViewModel();

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          homePageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => toUserSearchPage(context: context),
            icon: const Icon(
              Icons.person_search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _postViewModel.getFollowingUsersPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('友達の投稿を取得する際にエラーが出ました。'),
              );
            }

            final result = snapshot.data;

            if (result == 'no_following_user') {
              return const Center(
                child: Text('フォローしているユーザーがいません。'),
              );
            }
            if (result == 'no_post') {
              return const Center(
                child: Text('友達の投稿がありません'),
              );
            }
            if (result == null) {
              return const Center(
                child: Text('友達の投稿を取得する際に何らかのエラーが出ました。'),
              );
            }

            //_postViewModel.saveFollowingUsersPosts(result);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _postViewModel.followingUsersPosts.length,
                itemBuilder: (context, index) {
                  final post = _postViewModel.followingUsersPosts[index];
                  return QuizItem(post: post);
                });
          }),
    );
  }
}
