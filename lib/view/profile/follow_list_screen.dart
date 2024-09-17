import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/followed_user/followed_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/user_list_item.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:putone/view_model/user_search_view_model.dart';

class FollowListScreen extends ConsumerStatefulWidget {
  const FollowListScreen({
    super.key,
    required this.userProfile,
    required this.followingUsers,
    required this.followedUsers,
    required this.initialTab,
  });

  final UserProfile userProfile;
  final List<FollowingUser> followingUsers;
  final List<FollowedUser> followedUsers;
  final int initialTab;

  @override
  createState() {
    return FollowListScreenState();
  }
}

class FollowListScreenState extends ConsumerState<FollowListScreen> {
  final FollowViewModel followViewModel = FollowViewModel();
  final ProfileViewModel profileViewModel = ProfileViewModel();
  final UserSearchViewModel userSearchViewModel = UserSearchViewModel();
  // UserProfile userProfile = UserProfile(
  //   uid: '',
  //   userId: '',
  //   userName: '',
  //   userImg: '',
  //   themeMusicImg: '',
  //   themeMusicArtistName: '',
  //   themeMusicName: '',
  //   themeMusicSpotifyUrl: '',
  //   themeMusicPreviewUrl: '',
  //   userProfileMsg: '',
  //   userSpotifyConnected: false,
  //   userSignUpTimestamp: DateTime.now(),
  //   userLastLoginTimestamp: DateTime.now(),
  //   communityId: '',
  // );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Following: ${widget.followingUsers}');
    print('Followed by: ${widget.followedUsers}');

    profileViewModel.setRef(ref);

    return DefaultTabController(
      initialIndex: widget.initialTab,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userProfile.userName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: AppColorTheme.color().accentColor,
            tabs: const [
              Tab(
                child: Text(
                  followerCountLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  followingCountLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.followedUsers.length,
                        itemBuilder: (context, index) {
                          final uid = widget.followedUsers[index].uid;
                          return FutureBuilder(
                            future: followViewModel.getUserProfile(uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return UserListItem(
                                    userProfile: snapshot
                                        .data!); // Use the fetched user profile
                              } else {
                                return Container(
                                  width: double.infinity,
                                  height: 20,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.followingUsers.length,
                          itemBuilder: (context, index) {
                            final followingUid =
                                widget.followingUsers[index].followingUid;
                            return FutureBuilder(
                              future:
                                  followViewModel.getUserProfile(followingUid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return UserListItem(
                                      userProfile: snapshot
                                          .data!); // Use the fetched user profile
                                } else {
                                  return Container(
                                    width: double.infinity,
                                    height: 20,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
