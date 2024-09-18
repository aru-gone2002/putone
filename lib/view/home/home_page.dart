import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/enums.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/item/quiz_item.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PostViewModel _postViewModel = PostViewModel();
  final FollowViewModel _followViewModel = FollowViewModel();

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
    _followViewModel.setRef(ref);
  }

  Widget followingFriendsPostsList(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.hasError) {
      return const Center(
        child: Text(failToGetFollowingUsersPostsErrorText),
      );
    }
    if (_postViewModel.getFollowingUsersPostsCondition ==
        GetFollowingUsersPostsCondition.error) {
      return const Center(
        child: Text(failToGetFollowingUsersPostsErrorText),
      );
    }
    if (_postViewModel.getFollowingUsersPostsCondition ==
        GetFollowingUsersPostsCondition.lackOfFriends) {
      return const Center(
        child: Text(lackOfFriendsText),
      );
    }
    if (_postViewModel.getFollowingUsersPostsCondition ==
        GetFollowingUsersPostsCondition.noPost) {
      return const Center(
        child: Text(noFriendsPostText),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _postViewModel.followingUsersPosts.length,
      itemBuilder: (context, index) {
        final post = _postViewModel.followingUsersPosts[index];
        return QuizItem(post: post);
      },
    );
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
        future: Future.wait([
          _postViewModel.getFollowingUsersPosts(),
          _followViewModel.getFollowingUsers(),
        ]),
        builder: (context, snapshot) {
          return followingFriendsPostsList(snapshot);
        },
      ),
    );
  }
}
