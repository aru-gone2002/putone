import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/followed_user/followed_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/follow_button.dart';
import 'package:putone/view/profile/friend_post_grid_view.dart';
import 'package:putone/view/profile/post_grid_view.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:putone/view/item/follow_count.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/data/post/post.dart';

class FriendProfilePage extends ConsumerStatefulWidget {
  const FriendProfilePage({
    super.key,
    required this.userProfile,
  });

  final UserProfile userProfile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FriendProfilePageState();
  }
}

class FriendProfilePageState extends ConsumerState<FriendProfilePage> {
  late Future<List<FollowingUser>> _followingUsersFuture;
  late Future<List<FollowedUser>> _followedUsersFuture;

  final FollowViewModel followViewModel = FollowViewModel();
  final ProfileViewModel profileViewModel = ProfileViewModel();
  final PostViewModel postViewModel = PostViewModel();

  @override
  void initState() {
    super.initState();
    followViewModel.setRef(ref);
    profileViewModel.setRef(ref);

    _followingUsersFuture =
        followViewModel.getFriendFollowingUsers(widget.userProfile.uid);
    _followedUsersFuture =
        followViewModel.getFriendFollowedUsers(widget.userProfile.uid);
  }

  @override
  Widget build(BuildContext context) {
    const double sideProfileWidth = 132;
    const double profileImgSize = 112;

    return Scaffold(
      body: Column(
        children: [
          // ヘッダー
          Container(
            decoration: BoxDecoration(
              color: AppColorTheme.color().mainColor,
            ),
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: const Alignment(-0.93, 0.9),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      print('Navigating back to profile page.');
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 32,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.6),
                  child: Text(
                    widget.userProfile.userName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  AppColorTheme.color().mainColor,
                ],
              ),
            ),
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: const Alignment(-0.95, -0.85),
                  child: Container(
                    height: 48,
                    width: sideProfileWidth,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColorTheme.color().gray2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (widget.userProfile.themeMusicImg != '')
                            ? ExtendedImage.network(
                                widget.userProfile.themeMusicImg,
                                height: favoriteMusicImgHeight,
                                width: favoriteMusicImgWidth,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.rectangle,
                              )
                            : const Image(
                                width: favoriteMusicImgWidth,
                                height: favoriteMusicImgHeight,
                                image: AssetImage(
                                  'assets/images/favorite_song_is_not_selected.png',
                                ),
                              ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (widget.userProfile.themeMusicName != '')
                                    ? widget.userProfile.themeMusicName
                                    : themeSongIsNotSelectedText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                (widget.userProfile.themeMusicArtistName != '')
                                    ? widget.userProfile.themeMusicArtistName
                                    : askToSettingThemeSongText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.95, 0),
                  child: SizedBox(
                    width: sideProfileWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.userProfile.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${widget.userProfile.userId}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                //フォロワー数
                FutureBuilder(
                  future: Future.wait([
                    _followingUsersFuture,
                    _followedUsersFuture,
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is List) {
                      final int followedNum =
                          snapshot.data![1].length as int? ?? 0;
                      return Align(
                        alignment: const Alignment(-0.925, 0.75),
                        child: FollowCount(
                          count: followedNum,
                          label: followerCountLabel,
                          onTap: () {
                            print('Tapped follower button.');
                            toFollowListPage(
                              context: context,
                              userProfile: widget.userProfile,
                              followingUsers:
                                  snapshot.data![0] as List<FollowingUser>? ??
                                      [],
                              followedUsers:
                                  snapshot.data![1] as List<FollowedUser>? ??
                                      [],
                              initialTab: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Align(
                        alignment: const Alignment(-0.925, 0.75),
                        child: FollowCount(
                          count: 0,
                          label: followerCountLabel,
                          onTap: () {},
                        ),
                      );
                    }
                  },
                ),

                //フォロー中数
                FutureBuilder(
                  future: Future.wait([
                    _followingUsersFuture,
                    _followedUsersFuture,
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is List) {
                      final int followingNum =
                          snapshot.data![0].length as int? ?? 0;
                      return Align(
                        alignment: const Alignment(-0.525, 0.75),
                        child: FollowCount(
                          count: followingNum,
                          label: followingCountLabel,
                          onTap: () {
                            print('Tapped following button.');
                            toFollowListPage(
                              context: context,
                              userProfile: widget.userProfile,
                              followingUsers:
                                  snapshot.data![0] as List<FollowingUser>? ??
                                      [],
                              followedUsers:
                                  snapshot.data![1] as List<FollowedUser>? ??
                                      [],
                              initialTab: 1,
                            );
                          },
                        ),
                      );
                    } else {
                      return Align(
                        alignment: const Alignment(-0.525, 0.75),
                        child: FollowCount(
                          count: 0,
                          label: followingCountLabel,
                          onTap: () {},
                        ),
                      );
                    }
                  },
                ),

                Align(
                  alignment: const Alignment(0, 0),
                  child: (widget.userProfile.userImg != '')
                      ? ExtendedImage.network(
                          widget.userProfile.userImg,
                          width: profileImgSize,
                          height: profileImgSize,
                          fit: BoxFit.cover,
                          cache: true,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColorTheme.color().mainColor,
                          ),
                        )
                      : ExtendedImage.asset(
                          'assets/images/user_gray_icon.png',
                          width: profileImgSize,
                          height: profileImgSize,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                          border: Border.all(
                              color: AppColorTheme.color().mainColor,
                              width: 3.0),
                        ),
                ),
                // DMボタン
                Align(
                  alignment: const Alignment(0.35, -0.9),
                  child: IconButton(
                    onPressed: () {
                      print('Navigating to DMs.');
                    },
                    icon: const Icon(Icons.mail_outline),
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                // フォローボタン
                Align(
                  alignment: const Alignment(0.9, -0.9),
                  child: Consumer(builder: (context, ref, _) {
                    profileViewModel.setRef(ref);
                    return FollowButton(
                      followingUser: FollowingUser(
                        uid: profileViewModel.uid,
                        followingUid: widget.userProfile.uid,
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: const Alignment(0.95, 0),
                  child: SizedBox(
                    width: sideProfileWidth,
                    child: Text(
                      (widget.userProfile.userProfileMsg != '')
                          ? widget.userProfile.userProfileMsg
                          : notRegisteredProfileMsgText,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.95, 0.75),
                  child: SizedBox(
                    width: sideProfileWidth,
                    child: Text(
                      '所属：${profileViewModel.communityMap[(widget.userProfile.communityId)]!.communityName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //投稿表示画面
          Expanded(
            child: FutureBuilder<List<Post>?>(
              future: postViewModel.getUserPosts(widget.userProfile.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(failToReadDataErrorText),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(noPostText),
                  );
                }
                // 自分以外ように作る必要がある。
                return FriendPostGridView(snapshot: snapshot);
              },
            ),
          ),
        ],
      ),
    );
  }
}
