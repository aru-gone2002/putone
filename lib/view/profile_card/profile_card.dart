import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/local_database.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/theme/app_font_theme.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class ProfileCardPage extends ConsumerWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SpotifyViewModel spotifyViewModel = SpotifyViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    localDatabaseViewModel.setRef(ref);

    // userprofileを取得
    final appDatabase = ref.watch(appDataBaseProvider);
    return Scaffold(
      body: StreamBuilder<List<LocalUserProfile>>(
        stream: appDatabase?.watchAllLocalUserProfiles(),
        builder: (context, userProfileSnapshot) {
          if (!userProfileSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userProfile = userProfileSnapshot.data!.first;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 背景画像（ぼかし処理）
              if (userProfile.themeMusicImg.isNotEmpty)
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Image.network(
                    userProfile.themeMusicImg,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColorTheme.color().mainColor,
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              // コンテンツ
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'PuTone',
                      style: AppFontTheme.font(context)
                          .logoFont
                          .copyWith(fontSize: 30),
                      selectionColor: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    // プロフィール画像と名前
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userProfile.userImg),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      userProfile.userName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'THEME SONG',
                      style: GoogleFonts.emblemaOne(
                        textStyle: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                    // テーマソング表示
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            if (userProfile.themeMusicImg.isNotEmpty)
                              Image.network(
                                userProfile.themeMusicImg,
                                height: 50,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            else
                              Container(
                                height: 50,
                                width: 200,
                                color: AppColorTheme.color().gray3,
                                child: Icon(
                                  Icons.music_note,
                                  size: 100,
                                  color: AppColorTheme.color().gray1,
                                ),
                              ),
                            const SizedBox(height: 10),
                            Text(
                              userProfile.themeMusicName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              userProfile.themeMusicArtistName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // お気に入りアーティスト表示
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ARTIST',
                        style: GoogleFonts.emblemaOne(
                          textStyle:
                              TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<LocalUserFavoriteArtist>>(
                      stream: appDatabase?.watchAllLocalUserFavoriteArtists(),
                      builder: (context, artistsSnapshot) {
                        if (!artistsSnapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final artists = artistsSnapshot.data!.take(9).toList();

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2), // ここでパディングを小さく設定
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: artists.length,
                          itemBuilder: (context, index) {
                            final artist = artists[index];
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(10), // 角を丸くする
                                  child: Image.network(
                                    artist.userFavoriteArtistImg,
                                    width: MediaQuery.of(context).size.width /
                                        5.0, // Responsive width
                                    height:
                                        MediaQuery.of(context).size.width / 5.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Flexible(
                                  child: Text(
                                    artist.userFavoriteArtistName,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          userProfile.themeMusicName.isNotEmpty
                                              ? Colors.white
                                              : Colors.black,
                                    ), // フォントサイズを調整
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
