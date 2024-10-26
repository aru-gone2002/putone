import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/local_database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/follow_count.dart';
import 'package:putone/view/profile/favorite_artist_list_view.dart';
import 'package:putone/view/profile/friend_profile_page.dart';
import 'package:putone/view/profile/post_grid_view.dart';
import 'package:putone/view/profile/profile_drawer.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final PostViewModel postViewModel = PostViewModel();
    final SpotifyViewModel spotifyViewModel = SpotifyViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    final FollowViewModel followViewModel = FollowViewModel();
    final GlobalObjectKey<ScaffoldState> scaffoldKey = GlobalObjectKey(context);
    authViewModel.setRef(ref);
    profileViewModel.setRef(ref);
    postViewModel.setRef(ref);
    spotifyViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);
    followViewModel.setRef(ref);

    const double sideProfileWidth = 132;
    const double profileImgSize = 112;

    Future<void> createPostFunction(SpotifyTrack spotifyTrack) async {
      toPostAddMsgPage(context: context, selectedTrack: spotifyTrack);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        //ここのStreamBuilderのやつを変更する
        body: SafeArea(
          child: Column(
            children: [
              //プロフィールのトップ画面
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
                child: StreamBuilder<Object>(
                    stream: localDatabaseViewModel.appDatabase!
                        .watchAllLocalUserProfiles(),
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
                          child: Text(notExistProfileDataText),
                        );
                      }
                      //リストの中身を消しただけではhasDataがtrueのままになってしまうことがわかった
                      return (snapshot.data as List<LocalUserProfile>).isEmpty
                          ? const Center(
                              child: Text(notExistProfileDataText),
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                //左のライン
                                //お気に入り楽曲の表示
                                Align(
                                  alignment: const Alignment(-0.95, -0.85),
                                  child: Container(
                                    height: 48,
                                    width: sideProfileWidth,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColorTheme.color().gray2,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //アプリを閉じて再度開いた場合、
                                        //この時点でUserProfileProviderにローカルのデータが入っている必要がある。
                                        //UserProfileProviderには情報が入っていない可能性があるため分岐を行う必要がある。
                                        //ログインとかした場合には事前にFirestoreから情報を取得して、
                                        //UserProfileProviderにデータが入った状態となっている
                                        (snapshot.data as List<
                                                        LocalUserProfile>)
                                                    .first
                                                    .themeMusicImg !=
                                                ''
                                            ? ExtendedImage.network(
                                                //ローカルDBから画像を取得
                                                (snapshot.data as List<
                                                        LocalUserProfile>)
                                                    .first
                                                    .themeMusicImg,
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
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (snapshot.data as List<
                                                                LocalUserProfile>)
                                                            .first
                                                            .themeMusicName !=
                                                        ''
                                                    ? (snapshot.data as List<
                                                            LocalUserProfile>)
                                                        .first
                                                        .themeMusicName
                                                    : themeSongIsNotSelectedText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                (snapshot.data as List<
                                                                LocalUserProfile>)
                                                            .first
                                                            .themeMusicName !=
                                                        ''
                                                    ? (snapshot.data as List<
                                                            LocalUserProfile>)
                                                        .first
                                                        .themeMusicArtistName
                                                    : askToSettingThemeSongText,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //ユーザー名とユーザーID
                                Align(
                                  alignment: const Alignment(-0.95, 0),
                                  child: SizedBox(
                                    width: sideProfileWidth,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //ユーザー名
                                        Text(
                                          (snapshot.data
                                                  as List<LocalUserProfile>)
                                              .first
                                              .userName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),

                                        //ユーザーID
                                        Text(
                                          '@${(snapshot.data! as List<LocalUserProfile>).first.userId}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //フォロワー数
                                Align(
                                  alignment: const Alignment(-0.925, 0.75),
                                  child: FollowCount(
                                    count: followViewModel.followedNum,
                                    label: followerCountLabel,
                                    onTap: () {
                                      print('Tapped follower button.');
                                      toFollowListPage(
                                        context: context,
                                        userProfile:
                                            profileViewModel.userProfile,
                                        followingUsers:
                                            followViewModel.followingUsers,
                                        followedUsers:
                                            followViewModel.followedUsers,
                                        initialTab: 0,
                                      );
                                    },
                                  ),
                                ),
                                //フォロー中数
                                Align(
                                  alignment: const Alignment(-0.525, 0.75),
                                  child: FollowCount(
                                    count: followViewModel.followingNum,
                                    label: followingCountLabel,
                                    onTap: () {
                                      print('Tapped following button.');
                                      toFollowListPage(
                                        context: context,
                                        userProfile:
                                            profileViewModel.userProfile,
                                        followingUsers:
                                            followViewModel.followingUsers,
                                        followedUsers:
                                            followViewModel.followedUsers,
                                        initialTab: 1,
                                      );
                                    },
                                  ),
                                ),

                                //真ん中
                                //ユーザー画像の表示
                                Align(
                                  alignment: const Alignment(0, 0),
                                  child:
                                      (snapshot.data as List<LocalUserProfile>)
                                                  .first
                                                  .userImg !=
                                              ''
                                          ? ExtendedImage.network(
                                              (snapshot.data
                                                      as List<LocalUserProfile>)
                                                  .first
                                                  .userImg,
                                              width: profileImgSize,
                                              height: profileImgSize,
                                              fit: BoxFit.cover,
                                              cache: true,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColorTheme.color()
                                                      .mainColor),
                                            )
                                          : ExtendedImage.asset(
                                              'assets/images/user_gray_icon.png',
                                              width: profileImgSize,
                                              height: profileImgSize,
                                              shape: BoxShape.circle,
                                              fit: BoxFit.cover,
                                              border: Border.all(
                                                  color: AppColorTheme.color()
                                                      .mainColor,
                                                  width: 3.0),
                                            ),
                                ),
                                //右のライン
                                //編集ボタン
                                Align(
                                  alignment: const Alignment(0.65, -0.9),
                                  child: ElevatedButton.icon(
                                    label: const Text(editBtnText),
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                    //プロフィール編集画面を作成する
                                    onPressed: () =>
                                        toEditProfilePage(context: context),
                                    //toEditProfilePage(context: context),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      backgroundColor:
                                          AppColorTheme.color().gray2,
                                      foregroundColor: Colors.white,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                    ),
                                  ),
                                ),
                                //ハンバーガーメニュー
                                Align(
                                  alignment: const Alignment(0.95, -0.9),
                                  child: IconButton(
                                    icon: const Icon(Icons.dehaze_sharp),
                                    onPressed: () {
                                      scaffoldKey.currentState?.openEndDrawer();
                                    },
                                  ),
                                ),
                                //プロフィール文
                                Align(
                                  alignment: const Alignment(0.95, 0),
                                  child: SizedBox(
                                    width: sideProfileWidth,
                                    child: Text(
                                      (snapshot.data as List<LocalUserProfile>)
                                                  .first
                                                  .userProfileMsg !=
                                              ''
                                          ? (snapshot.data
                                                  as List<LocalUserProfile>)
                                              .first
                                              .userProfileMsg
                                          : notRegisteredProfileMsgText,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                                //所属先
                                Align(
                                  alignment: const Alignment(0.95, 0.75),
                                  child: SizedBox(
                                    width: sideProfileWidth,
                                    child: Text(
                                      '所属：${profileViewModel.communityMap[(snapshot.data as List<LocalUserProfile>).first.communityId]!.communityName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }),
              ),
              //タブバー
              TabBar(
                  labelColor: AppColorTheme.color().accentColor,
                  unselectedLabelColor: Colors.grey,
                  // indicatorColor: AppColorTheme.color().accentColor,
                  indicator: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  tabs: const <Widget>[
                    Tab(
                      icon: Icon(Icons.grid_on),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.card_giftcard),
                    ),
                  ]),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    //投稿表示画面
                    StreamBuilder<Object>(
                      stream: localDatabaseViewModel.appDatabase!
                          .watchAllLocalUserPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        return PostGridView(snapshot: snapshot);
                      },
                    ),
                    //お気に入りアーティスト表示画面
                    const FavoriteArtistListView(),
                    Center(child: Text('グッズ')),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawer: ProfileDrawer(database: localDatabaseViewModel.appDatabase!),
        floatingActionButton: FloatingActionButton(
          //投稿ページに飛ぶようにする
          onPressed: () {
            // await spotifyViewModel.fetchSpotifyAccessToken();
            toSelectSongPage(
              context: context,
              appBarTitle: postCreatePageAppbarTitle,
              onTap: createPostFunction,
              isVisibleCurrentMusicInfo: false,
            );
          },
          backgroundColor: AppColorTheme.color().accentColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
