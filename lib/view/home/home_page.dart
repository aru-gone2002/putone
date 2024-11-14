import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/post/post_grid_view.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
    _followViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
    _localDatabaseViewModel.setRef(ref);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadFollowingsPosts();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadFollowingsPosts() async {
    await _followViewModel.getFollowingUsers(_profileViewModel.uid);
    final followingUids =
        _followViewModel.followingUsers.map((e) => e.uid).toList();
    await _postViewModel.getFollowingUsersPosts(followingUids: followingUids);
    setState(() {
      isLoading = false;
    });
  }

  Widget followingFriendsPostsList() {
    final followingUsersPosts = _postViewModel.followingUsersPosts;
    final followingUsers = _followViewModel.followingUsers;
    if (followingUsers.isEmpty) {
      return const Center(
        child: Text(noFriendsText),
      );
    }
    if (followingUsersPosts.isEmpty) {
      return const Center(
        child: Text(noFriendsPostText),
      );
    }
    //TODO post_grid_viewを使う
    return PostGridView(posts: followingUsersPosts);
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followingFriendsPostsList(),
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
