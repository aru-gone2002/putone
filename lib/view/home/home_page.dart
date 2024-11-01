import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/constants/enums.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/model/friends_quiz_model.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/home/my_quiz_page.dart';
import 'package:putone/view/item/quiz_item.dart';
import 'package:putone/view/item/button/small_color_button.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/friends_quiz_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PostViewModel _postViewModel = PostViewModel();
  final FollowViewModel _followViewModel = FollowViewModel();
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final LocalDatabaseViewModel _localDatabaseViewModel =
      LocalDatabaseViewModel();
  final FriendsQuizViewModel _friendsQuizViewModel = FriendsQuizViewModel();
  final PageController _controller = PageController(initialPage: 0);
  int page = 0;

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
    _followViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
    _localDatabaseViewModel.setRef(ref);
    _friendsQuizViewModel.setRef(ref);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadFriendsPosts() async {
    final localUserPostAnswers =
        await _localDatabaseViewModel.appDatabase!.getAllLocalUserPostAnswers();
    print('home_pageにてgetAllLocalUserPostAnswersを実行');
    print('localUserPostAnswers: $localUserPostAnswers');
    //providerに友達のクイズへの回答状況を保存
    if (localUserPostAnswers.isNotEmpty) {
      _friendsQuizViewModel.savePostAnswers(_friendsQuizViewModel
          .changeLocalUserPostAnswerstoPostAnswers(localUserPostAnswers));
    }
    await _postViewModel.getFollowingUsersPosts();
    print('_postViewModel.getFollowingUsersPosts()を実施');
    await _followViewModel.getFollowingUsers(_profileViewModel.uid);
    print('_followViewModel.getFollowingUsers(_profileViewModel.uid)を実施');
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
          //style: Theme.of(context).textTheme.headlineMedium,
          style: GoogleFonts.carterOne(
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
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
      body: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                    setState(() {
                      page = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: page == 0
                          ? AppColorTheme.color().accentColor
                          : Colors.black,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    backgroundColor:
                        //TODO 選択されていたらaccentColor
                        //選択されていなかったらwhite
                        page == 0
                            ? AppColorTheme.color().accentColor
                            : Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    '友達の投稿',
                    style: TextStyle(
                      fontSize: 16,
                      color: page == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    _controller.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                    setState(() {
                      page = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: page == 1
                          ? AppColorTheme.color().accentColor
                          : Colors.black,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    backgroundColor:
                        //TODO 選択されていたらaccentColor
                        //選択されていなかったらwhite
                        page == 1
                            ? AppColorTheme.color().accentColor
                            : Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    '自分の投稿',
                    style: TextStyle(
                      fontSize: 16,
                      color: page == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //const SizedBox(height: 8),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                FutureBuilder(
                  future: _loadFriendsPosts(),
                  builder: (context, snapshot) {
                    return followingFriendsPostsList(snapshot);
                  },
                ),
                const MyQuizPage(),
              ],
            ),
            // child: FutureBuilder(
            //   future: _loadFriendsPosts(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return const Center(
            //         child: Text(failToGetFollowingUsersPostsErrorText),
            //       );
            //     }
            //     return PageView(
            //       controller: _controller,
            //       children: [
            //         followingFriendsPostsList(snapshot),
            //         const MyQuizPage(),
            //       ],
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
