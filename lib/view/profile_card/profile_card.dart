import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/theme/app_font_theme.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';
import 'package:putone/view_model/item_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ProfileCardPage extends ConsumerWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
    final ItemViewModel itemViewModel = ItemViewModel();
    final PostViewModel postViewModel = PostViewModel();
    profileViewModel.setRef(ref);
    artistFollowViewModel.setRef(ref);
    itemViewModel.setRef(ref);
    postViewModel.setRef(ref);

    final artists = artistFollowViewModel.favoriteArtists.take(9).toList();
    final posts = postViewModel.posts.toList();
    posts.sort((a, b) => b.postTimestamp.compareTo(a.postTimestamp));
    final merchs = itemViewModel.userItems.toList();
    merchs.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final sevenPosts = posts.take(7).toList();
    final threeMerchs = merchs.take(3).toList();

    Widget firstPage = Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: [
        // 背景画像（ぼかし処理）
        if (profileViewModel.themeMusicImg.isNotEmpty &&
            profileViewModel.themeMusicImg.trim() != '')
          Stack(
            fit: StackFit.expand,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: ExtendedImage.network(
                  profileViewModel.themeMusicImg,
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
            mainAxisSize: MainAxisSize.min,
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
              ExtendedImage.network(
                profileViewModel.userImg,
                fit: BoxFit.cover,
                cache: true,
                shape: BoxShape.circle,
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.height * 0.12,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                profileViewModel.userName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: profileViewModel.themeMusicName.isNotEmpty
                        ? Colors.white
                        : AppColorTheme.color().gray1),
              ),
              Text(
                profileViewModel.userId,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: profileViewModel.themeMusicName.isNotEmpty
                        ? Colors.white
                        : AppColorTheme.color().gray1),
              ),
              // テーマソング
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'THEME SONG',
                      style: GoogleFonts.emblemaOne(
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.05,
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
                    height:
                        MediaQuery.of(context).size.height * 0.13, // カードの高さを固定
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  if (profileViewModel
                                          .themeMusicImg.isNotEmpty &&
                                      profileViewModel.themeMusicImg.trim() !=
                                          '')
                                    ExtendedImage.network(
                                      profileViewModel.themeMusicImg,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      fit: BoxFit.cover,
                                      cache: true,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                  else
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: AppColorTheme.color().gray3,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.music_note,
                                        size: 40,
                                        color: AppColorTheme.color().gray1,
                                      ),
                                    ),
                                  const SizedBox(width: 16),
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
                                            profileViewModel
                                                    .themeMusicName.isNotEmpty
                                                ? profileViewModel
                                                    .themeMusicName
                                                : 'No theme song set',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        if (profileViewModel
                                                .themeMusicArtistName
                                                .isNotEmpty &&
                                            profileViewModel
                                                    .themeMusicArtistName
                                                    .trim() !=
                                                '')
                                          Text(
                                            profileViewModel
                                                .themeMusicArtistName,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
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
                ],
              ),

              Stack(
                  // お気に入りアーティスト表示
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'ARTISTS',
                        style: GoogleFonts.emblemaOne(
                          textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.05,
                              color: AppColorTheme.color().gray1),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.15,
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.width * 0.15,
                          0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                              ExtendedImage.network(
                                artist.artistImg,
                                width: MediaQuery.of(context).size.width / 4.8,
                                height: MediaQuery.of(context).size.width / 4.8,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              const SizedBox(height: 2),
                              Flexible(
                                // パディングを小さく設定
                                child: Text(
                                  artist.artistName,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: profileViewModel
                                            .themeMusicName.isNotEmpty
                                        ? Colors.white
                                        : Colors.black,
                                  ), // フォントサイズを調整
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ])
            ],
          ),
        ),
      ],
    );

    Widget secondPage = Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: [
        // 背景画像（ぼかし処理）
        if (profileViewModel.themeMusicImg.isNotEmpty &&
            profileViewModel.themeMusicImg.trim() != '')
          Stack(
            fit: StackFit.expand,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: ExtendedImage.network(
                  profileViewModel.themeMusicImg,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'POSTS',
                      style: GoogleFonts.emblemaOne(
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.05,
                            color: AppColorTheme.color().gray1),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1,
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03,
                      ),
                      width: MediaQuery.of(context).size.width * 0.94,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                height: MediaQuery.of(context).size.width *
                                    (166 / 300 + 0.02),
                                width: MediaQuery.of(context).size.width *
                                    (166 / 300 + 0.02),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: ExtendedImage.network(
                                        //TODO 後でエラーハンドリング
                                        sevenPosts[0].postMusicImg,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (166 / 300 + 0.02),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                (166 / 300 + 0.02),
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (166 / 300 + 0.02),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                (166 / 300 + 0.03),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                            stops: const [0.1, 0.6, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.95, 0.85),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.music_note_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                150 /
                                                300,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sevenPosts[0].postMusicName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  sevenPosts[0]
                                                      .postMusicArtistName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //     width:
                              //         MediaQuery.of(context).size.width * 0.04),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: MediaQuery.of(context).size.width *
                                        86 /
                                        300,
                                    width: MediaQuery.of(context).size.width *
                                        86 /
                                        300,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, 0),
                                          child: ExtendedImage.network(
                                            //TODO 後でエラーハンドリング
                                            sevenPosts[1].postMusicImg,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            fit: BoxFit.cover,
                                            cache: true,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.2),
                                                  Colors.black.withOpacity(0),
                                                  Colors.black.withOpacity(0.8),
                                                ],
                                                stops: const [0.1, 0.6, 1.0],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const Alignment(-0.95, 0.85),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.music_note_outlined,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 4),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    63 /
                                                    300,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      sevenPosts[1]
                                                          .postMusicName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      sevenPosts[1]
                                                          .postMusicArtistName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: MediaQuery.of(context).size.width *
                                        86 /
                                        300,
                                    width: MediaQuery.of(context).size.width *
                                        86 /
                                        300,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, 0),
                                          child: ExtendedImage.network(
                                            //TODO 後でエラーハンドリング
                                            sevenPosts[2].postMusicImg,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            fit: BoxFit.cover,
                                            cache: true,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                86 /
                                                300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.2),
                                                  Colors.black.withOpacity(0),
                                                  Colors.black.withOpacity(0.8),
                                                ],
                                                stops: const [0.1, 0.6, 1.0],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const Alignment(-0.95, 0.85),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.music_note_outlined,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 4),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    63 /
                                                    300,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      sevenPosts[2]
                                                          .postMusicName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      sevenPosts[2]
                                                          .postMusicArtistName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                width: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: ExtendedImage.network(
                                        //TODO 後でエラーハンドリング
                                        sevenPosts[3].postMusicImg,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                            stops: const [0.1, 0.6, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.95, 0.85),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.music_note_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                63 /
                                                300,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sevenPosts[3].postMusicName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  sevenPosts[3]
                                                      .postMusicArtistName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                width: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: ExtendedImage.network(
                                        //TODO 後でエラーハンドリング
                                        sevenPosts[4].postMusicImg,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                            stops: const [0.1, 0.6, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.95, 0.85),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.music_note_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                63 /
                                                300,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sevenPosts[4].postMusicName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  sevenPosts[4]
                                                      .postMusicArtistName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                width: MediaQuery.of(context).size.width *
                                    86 /
                                    300,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: ExtendedImage.network(
                                        //TODO 後でエラーハンドリング
                                        sevenPosts[5].postMusicImg,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                86 /
                                                300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                            stops: const [0.1, 0.6, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.95, 0.85),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.music_note_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                63 /
                                                300,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sevenPosts[5].postMusicName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  sevenPosts[5]
                                                      .postMusicArtistName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'MERCH',
                      style: GoogleFonts.emblemaOne(
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.05,
                            color: AppColorTheme.color().gray1),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.03,
                          MediaQuery.of(context).size.height * 0.05,
                          MediaQuery.of(context).size.width * 0.03,
                          0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.94,
                        height: MediaQuery.of(context).size.height *
                            0.13, // カードの高さを固定
                        clipBehavior: Clip.hardEdge, //要素をくっつける
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // カードの角を丸くする
                        ),
                        child: Flexible(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  ExtendedImage.network(
                                    merchs[0].itemImgs[0],
                                    width: MediaQuery.of(context).size.height *
                                        0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    fit: BoxFit.cover,
                                    cache: true,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            merchs[0].itemName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Text(
                                          merchs[0].artistName,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
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
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.03,
                          0,
                          MediaQuery.of(context).size.width * 0.03,
                          0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.94,
                        height: MediaQuery.of(context).size.height *
                            0.13, // カードの高さを固定
                        clipBehavior: Clip.hardEdge, //要素をくっつける
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // カードの角を丸くする
                        ),
                        child: Flexible(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  ExtendedImage.network(
                                    merchs[1].itemImgs[0],
                                    width: MediaQuery.of(context).size.height *
                                        0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    fit: BoxFit.cover,
                                    cache: true,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            merchs[1].itemName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Text(
                                          merchs[1].artistName,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
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
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      body: PageView(
        controller: PageController(initialPage: 0),
        children: [firstPage, secondPage],
      ),
    );
  }
}
