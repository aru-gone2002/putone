import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/post/post_grid_view.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PostViewModel postViewModel = PostViewModel();
    final FollowViewModel followViewModel = FollowViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    postViewModel.setRef(ref);
    followViewModel.setRef(ref);
    profileViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);

    Future<void> loadFollowingsPosts() async {
      await followViewModel.getFollowingUsers(profileViewModel.uid);
      final followingUids =
          followViewModel.followingUsers.map((e) => e.followingUid).toList();
      await postViewModel.getFollowingUsersPosts(followingUids: followingUids);
    }

    Widget followingFriendsPostsList() {
      final followingUsersPosts = postViewModel.followingUsersPosts;
      final followingUsers = followViewModel.followingUsers;
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

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await loadFollowingsPosts();
    //   });
    //   return null;
    // }, []);

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
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: FutureBuilder(
            future: loadFollowingsPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(failToGetFollowingUsersPostsErrorText),
                );
              }
              return followingFriendsPostsList();
            }),
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
