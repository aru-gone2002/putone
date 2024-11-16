import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/view_model/community_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class CommunityPage extends ConsumerWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final CommunityViewModel communityViewModel = CommunityViewModel();
    profileViewModel.setRef(ref);
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
            return Wrap(
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
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  // style: Theme.of(context)
                                  //     .textTheme
                                  //     .headlineMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              //mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 12),
                                profileViewModel.themeMusicImg != ''
                                    ? ExtendedImage.network(
                                        //ローカルDBから画像を取得
                                        profileViewModel.themeMusicImg,
                                        width: favoriteMusicImgWidth,
                                        height: favoriteMusicImgHeight,
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
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileViewModel.themeMusicName != ''
                                          ? profileViewModel.themeMusicName
                                          : themeSongIsNotSelectedText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      profileViewModel.themeMusicName != ''
                                          ? profileViewModel
                                              .themeMusicArtistName
                                          : askToSettingThemeSongText,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            //TODO ここでfavoriteMusicのChipsを表示する
                            FutureBuilder(
                              future: getFavoriteArtists(uid: user.uid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isEmpty ||
                                      snapshot.data == null) {
                                    return const SizedBox(
                                      height: 60,
                                    );
                                  }
                                  return Wrap(
                                      children: snapshot.data!
                                          .map((artist) => Chip(
                                                label: Text(artist.artistName),
                                              ))
                                          .toList());
                                } else {
                                  return const SizedBox(
                                    height: 60,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
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
