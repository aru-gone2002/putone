import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:extended_image/extended_image.dart';

class FriendProfilePage extends ConsumerStatefulWidget {
  const FriendProfilePage({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  ConsumerState<FriendProfilePage> createState() {
    return FriendProfilePageState();
  }
}

class FriendProfilePageState extends ConsumerState<FriendProfilePage> {
  // フォローボタン変化の仮実装用
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalObjectKey<ScaffoldState> scaffoldKey = GlobalObjectKey(context);
    final FollowViewModel followViewModel = FollowViewModel();

    followViewModel.isFollowing(uid: widget.userProfile.uid).then((value) {
      setState() {
        isFollowing = value;
      }
    });

    const double sideProfileWidth = 132;
    const double profileImgSize = 112;

    void pressedFollowButton() {
      final String uid = widget.userProfile.uid;
      if (isFollowing) {
        followViewModel.unfollowUser(uid: uid);
        print('Unfollow: $uid');
        setState(() {
          isFollowing = false;
        });
      } else {
        followViewModel.followUser(uid: uid);
        print('Follow: $uid');
        setState(() {
          isFollowing = true;
        });
      }
    }

    return Scaffold(
      key: scaffoldKey,
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
                  child: ElevatedButton.icon(
                    onPressed: () {
                      pressedFollowButton();
                    },
                    label: Text((!isFollowing) ? 'フォロー' : 'フォロー中'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 6),
                      backgroundColor: (!isFollowing)
                          ? AppColorTheme.color().accentColor
                          : AppColorTheme.color().gray1,
                      foregroundColor: Colors.white,
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                    ),
                  ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
