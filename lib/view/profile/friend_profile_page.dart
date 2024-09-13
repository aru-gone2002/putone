import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/follow_button.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:extended_image/extended_image.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();

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
                    userProfile.userName,
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
                        (userProfile.themeMusicImg != '')
                            ? ExtendedImage.network(
                                userProfile.themeMusicImg,
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
                                (userProfile.themeMusicName != '')
                                    ? userProfile.themeMusicName
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
                                (userProfile.themeMusicArtistName != '')
                                    ? userProfile.themeMusicArtistName
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
                          userProfile.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${userProfile.userId}',
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
                  child: (userProfile.userImg != '')
                      ? ExtendedImage.network(
                          userProfile.userImg,
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
                        followingUid: userProfile.uid,
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: const Alignment(0.95, 0),
                  child: SizedBox(
                    width: sideProfileWidth,
                    child: Text(
                      (userProfile.userProfileMsg != '')
                          ? userProfile.userProfileMsg
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
