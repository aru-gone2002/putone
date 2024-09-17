import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';
import 'package:putone/after_signIn_page.dart';
import 'package:putone/local_database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/auth/email_auth_page.dart';
import 'package:putone/view/splash_screen.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class PuTone extends ConsumerWidget {
  const PuTone({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final PostViewModel postViewModel = PostViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    final FollowViewModel followViewModel = FollowViewModel();
    final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
    final SpotifyViewModel spotifyViewModel = SpotifyViewModel();
    authViewModel.setRef(ref);
    profileViewModel.setRef(ref);
    postViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);
    followViewModel.setRef(ref);
    artistFollowViewModel.setRef(ref);
    spotifyViewModel.setRef(ref);

    return MaterialApp(
      title: 'PuTone',
      theme: ThemeData(
        indicatorColor: AppColorTheme.color().mainColor,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColorTheme.color().mainColor,
          elevation: 0,
        ),
        fontFamily: 'NotoSans',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontSize: 16),
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      //home: AdminPage(database: database),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            if (authViewModel.isSignIn) {
              return nil;
            } else {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                print('snapshot.hasDataが実行されています');

                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  //await postViewModel.getFollowingUsersPosts();
                  //AppDataBaseのインスタンスをproviderに格納
                  localDatabaseViewModel
                      .saveAppDatabase(database); //これはレンダリングが終わったあとでもとりあえずOK
                  //ローカルDBからUserProfileデータを取得
                  final localUserProfiles =
                      await database.getLocalUserProfiles();
                  print('ローカルDBからUserProfileデータを取得');
                  final userBaseProfile = localUserProfiles.first;
                  print('firstを実行');
                  //localUserProfileの内容をproviderに入れる
                  profileViewModel.saveUserProfileLocalDBData(userBaseProfile);
                  print('saveUserProfileLocalDBDataを実施');
                  final localUserPosts = await database.getAllLocalUserPosts();
                  print('ローカルDBからUserPostsデータを取得');
                  //localUserPostsの内容をproviderに入れる
                  postViewModel.insertPostsToList(
                    postViewModel.changeLocalUserPoststoPosts(localUserPosts),
                  );
                  //ローカルDBからUserFavoriteArtistsのデータを取得
                  final localUserFavoriteArtists =
                      await database.getAllLocalUserFavoriteArtists();
                  //localUserFavoriteArtistsの内容をproviderに入れる
                  artistFollowViewModel.insertArtistsToList(
                    artistFollowViewModel
                        .changeLocalUserFavoriteArtiststoFavoriteArtists(
                            localUserFavoriteArtists),
                  );
                  //フォロー中のユーザーを取得し、providerに追加。
                  await followViewModel.getFollowingUsers();
                  await spotifyViewModel.fetchSpotifyAccessToken();
                });

                //手渡しでAppDatabaseのインスタンスを渡す
                return const AfterSignInPage();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  //AppDataBaseのインスタンスをproviderに格納
                  localDatabaseViewModel
                      .saveAppDatabase(database); //これはレンダリングが終わったあとでもとりあえずOK
                });
                localDatabaseViewModel
                    .saveAppDatabase(database); //これはレンダリングが終わったあとでもとりあえずOK
                return const EmailAuthPage();
              }
            }
          }
          //何もない時に表示される。
          WidgetsBinding.instance.addPostFrameCallback((_) {
            localDatabaseViewModel.saveAppDatabase(database);
          });
          return const AuthPage();
        },
      ),
    );
  }
}
