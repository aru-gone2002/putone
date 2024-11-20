import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';
import 'package:putone/view_model/community_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class CommunityPage extends ConsumerWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final CommunityViewModel communityViewModel = CommunityViewModel();
    final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
    profileViewModel.setRef(ref);
    artistFollowViewModel.setRef(ref);
    List<UserProfile>? communityUsers = [];
    //投稿のGridViewの横の長さを計算
    var size = MediaQuery.of(context).size;
    //投稿のGridViewの横の長さを計算
    final double memberItemWidth =
        (size.width - postGridViewCrossAxisSpacing - postGridPaddingWidth * 2) /
            2;

    Future<void> getCommunityUsers() async {
      final result = await communityViewModel.getCommunityUsers(
          communityId: profileViewModel.communityId);
      if (result == null) {
        print('fail to get community users');
        communityUsers = null;
      }
      if (result != null && result.isEmpty) {
        print('No community users');
        communityUsers = [];
      }
      if (result != null && result.isNotEmpty) {
        print(result);
        communityUsers = result;
      }
    }

    //TODO communityUsersのfavoriteArtistsを取得する
    Future<List<Artist>?> getFavoriteArtists({required String uid}) async {
      final result = await communityViewModel.getFavoriteArtists(uid: uid);
      if (result == null) {
        print('fail to get favorite artists');
        return null;
      }
      if (result.isEmpty) {
        print('No favorite artists');
        return [];
      }
      if (result.isNotEmpty) {
        print(result);
        return result;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: postGridViewCrossAxisSpacing,
          right: postGridViewCrossAxisSpacing,
          top: 16,
        ),
        child: FutureBuilder(
          future: getCommunityUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // TODO ここにcommunityUsersの表示を追加
            // wrapで実装する
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 32,
                      ),
                      Text(
                        profileViewModel
                            .communityMap[profileViewModel.communityId]!
                            .communityName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    runSpacing: 12,
                    alignment: WrapAlignment.spaceBetween,
                    children: communityUsers!
                        .map((user) => Container(
                              width: memberItemWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(2, 4),
                                    color: Color.fromARGB(50, 0, 0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),

                                  GestureDetector(
                                    onTap: () => toFriendProfilePage(
                                      context: context,
                                      userProfile: user,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 12),
                                        ExtendedImage.network(
                                          user.userImg,
                                          width: 40,
                                          height: 40,
                                          cache: true,
                                          shape: BoxShape.circle,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          user.userName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .headlineMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      //mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        user.themeMusicImg != ''
                                            ? ExtendedImage.network(
                                                //ローカルDBから画像を取得
                                                user.themeMusicImg,
                                                // width: favoriteMusicImgWidth,
                                                // height: favoriteMusicImgHeight,
                                                width: 56,
                                                height: 56,
                                                fit: BoxFit.cover,
                                                cache: true,
                                                shape: BoxShape.rectangle,
                                              )
                                            : const Image(
                                                // width: favoriteMusicImgWidth,
                                                // height: favoriteMusicImgHeight,
                                                width: 56,
                                                height: 56,
                                                image: AssetImage(
                                                  'assets/images/favorite_song_is_not_selected.png',
                                                ),
                                              ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.themeMusicName != ''
                                                    ? user.themeMusicName
                                                    : themeSongIsNotSelectedText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                user.themeMusicName != ''
                                                    ? user.themeMusicArtistName
                                                    : askToSettingThemeSongText,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[600],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  // const Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: const Text(
                                  //     'Favorite Artists',
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                  //TODO ここでfavoriteMusicのChipsを表示する
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'Favorite Artists',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FutureBuilder(
                                      future: getFavoriteArtists(uid: user.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isEmpty ||
                                              snapshot.data == null) {
                                            return const SizedBox(
                                              height: 100,
                                            );
                                          }
                                          return SizedBox(
                                            height: 100,
                                            child: SingleChildScrollView(
                                              child: Wrap(
                                                  spacing: 4,
                                                  runSpacing: 4,
                                                  children: snapshot.data!
                                                      .map((artist) => Chip(
                                                            backgroundColor: artistFollowViewModel
                                                                    .favoriteArtists
                                                                    .contains(
                                                                        artist)
                                                                ? AppColorTheme
                                                                        .color()
                                                                    .accentColor
                                                                : AppColorTheme
                                                                        .color()
                                                                    .gray3,
                                                            visualDensity:
                                                                const VisualDensity(
                                                              horizontal: 0.0,
                                                              vertical: -4,
                                                            ),
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            labelPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 1,
                                                            ),
                                                            label: Text(
                                                              artist.artistName,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: artistFollowViewModel
                                                                        .favoriteArtists
                                                                        .contains(
                                                                            artist)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList()),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox(
                                            height: 60,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
    // Center(
    //   child: ElevatedButton(
    //       onPressed: () async {
    //         final result = await communityViewModel.getCommunityUsers(
    //             communityId: profileViewModel.communityId);
    //         if (result == null) {
    //           print('fail to get community users');
    //         }
    //         if (result != null && result.isEmpty) {
    //           print('No community users');
    //         }
    //         if (result != null && result.isNotEmpty) {
    //           print(result);
    //         }
    //       },
    //       child: const Text('getCommunityUsers')),
    // );
  }
}
