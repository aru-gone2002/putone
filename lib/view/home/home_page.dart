import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view_model/follow_view_model.dart';
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
  final PageController _controller = PageController(initialPage: 0);
  int page = 0;

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
    _followViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
    _localDatabaseViewModel.setRef(ref);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadFriendsPosts() async {
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
    //TODO もし投稿がなかった時とかの処理
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _postViewModel.followingUsersPosts.length,
      itemBuilder: (context, index) {
        final post = _postViewModel.followingUsersPosts[index];
        // return QuizItem(post: post);
        return Text('友達の投稿の表示');
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
      body: Center(
        child: Text('ホーム画面'),
      ),

      // Column(
      //   children: [
      //     const SizedBox(height: 12),

      //const SizedBox(height: 8),
      // Expanded(
      //   child: PageView(
      //     controller: _controller,
      //     children: [
      //       FutureBuilder(
      //         future: _loadFriendsPosts(),
      //         builder: (context, snapshot) {
      //           return followingFriendsPostsList(snapshot);
      //         },
      //       ),
      //       const MyQuizPage(),
      //     ],
      //   ),
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
      // ),
      //   ],
      // ),
    );
  }
}
