import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/local_database.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/theme/app_font_theme.dart';
import 'package:putone/view_model/local_database_view_model.dart';

class ProfileCardPage extends ConsumerWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            clipBehavior: Clip.hardEdge,
            children: [
              // 背景画像（ぼかし処理）
              if (userProfile.themeMusicImg.isNotEmpty)
                Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: ExtendedImage.network(
                        userProfile.themeMusicImg,
                        fit: BoxFit.cover,
                        cache: true,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.45), // 黒いフィルター
                    ),
                  ],
                )
              else
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
                ),
              // コンテンツ
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      'PuTone',
                      style: (AppFontTheme.font(context)
                          .logoFont
                          .copyWith(fontSize: 15, color: Colors.white)),
                      selectionColor: Colors.white,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    // プロフィール画像と名前
                    Container(
                      child: ExtendedImage.network(
                        userProfile.userImg,
                        fit: BoxFit.cover,
                        cache: true,
                        shape: BoxShape.circle,
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.height * 0.12,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005),
                    Text(
                      userProfile.userName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: userProfile.themeMusicName.isNotEmpty
                              ? Colors.white
                              : AppColorTheme.color().gray1),
                    ),
                    Text(
                      userProfile.userId,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: userProfile.themeMusicName.isNotEmpty
                              ? Colors.white
                              : AppColorTheme.color().gray1),
                    ),

                    Stack(children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'THEME SONG',
                          style: GoogleFonts.emblemaOne(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.05,
                                color: AppColorTheme.color().gray1),
                          ),
                        ),
                      ),

                      // テーマソング表示
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.047,
                            MediaQuery.of(context).size.width * 0.05,
                            0),

                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height *
                            0.13, // カードの高さを固定
                        clipBehavior: Clip.hardEdge, //要素をくっつける
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // カードの角を丸くする
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ExtendedImage.asset(
                              'assets/images/disk_gray1.png',
                              width: MediaQuery.of(context).size.height * 0.06,
                              height: MediaQuery.of(context).size.height * 0.12,
                              fit: BoxFit.contain,
                              color: AppColorTheme.color().gray1,
                            ),
                            Flexible(
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppColorTheme.color().gray2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      if (userProfile.themeMusicImg.isNotEmpty)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            userProfile.themeMusicImg,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      else
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: BoxDecoration(
                                            color: AppColorTheme.color().gray3,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.music_note,
                                            size: 40,
                                            color: AppColorTheme.color().gray1,
                                          ),
                                        ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        // テキスト部分も Expanded で囲む
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                  userProfile.themeMusicName
                                                          .isNotEmpty
                                                      ? userProfile
                                                          .themeMusicName
                                                      : 'No theme song set',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2),
                                            ),
                                            if (userProfile.themeMusicArtistName
                                                .isNotEmpty)
                                              Text(
                                                userProfile
                                                    .themeMusicArtistName,
                                                style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),

                    Stack(
                        // お気に入りアーティスト表示
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Musicians',
                              style: GoogleFonts.emblemaOne(
                                textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                    color: AppColorTheme.color().gray1),
                              ),
                            ),
                          ),
                          StreamBuilder<List<LocalUserFavoriteArtist>>(
                            stream:
                                appDatabase?.watchAllLocalUserFavoriteArtists(),
                            builder: (context, artistsSnapshot) {
                              if (!artistsSnapshot.hasData) {
                                return const CircularProgressIndicator();
                              }

                              final artists =
                                  artistsSnapshot.data!.take(9).toList();

                              return Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.15,
                                      MediaQuery.of(context).size.width * 0.1,
                                      MediaQuery.of(context).size.width * 0.15,
                                      0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: GridView.builder(
                                    padding: EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1,
                                    ),
                                    itemCount: artists.length,
                                    itemBuilder: (context, index) {
                                      final artist = artists[index];
                                      return Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10), // 角を丸くする
                                            child: Image.network(
                                              artist.userFavoriteArtistImg,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.8, // Responsive width
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.8,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Flexible(
                                            // パディングを小さく設定
                                            child: Text(
                                              artist.userFavoriteArtistName,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: userProfile
                                                          .themeMusicName
                                                          .isNotEmpty
                                                      ? Colors.white
                                                      : Colors
                                                          .black), // フォントサイズを調整
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ));
                            },
                          ),
                        ])
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
