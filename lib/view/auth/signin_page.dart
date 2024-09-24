import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/friends_quiz_view_model.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final PostViewModel postViewModel = PostViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
    final FollowViewModel followViewModel = FollowViewModel();
    final SpotifyViewModel spotifyViewModel = SpotifyViewModel();
    final FriendsQuizViewModel friendsQuizViewModel = FriendsQuizViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    Future<void> signInFunction(
        GlobalObjectKey<FormState> formKey, WidgetRef ref) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        //firebase Authでメールアドレスとパスワードを使ってサインインする
        //isSignInをtrueにする。
        final signInResponse = await authViewModel.signInWithEmailAndPassword();

        if (signInResponse is FirebaseAuthException) {
          await Fluttertoast.showToast(
              msg: switch (signInResponse.code) {
            'invalid-email' || 'user-disabled' => invalidEmailText,
            'user-not-found' => userNotFoundText,
            'wrong-password' => wrongPasswordText,
            _ => signInErrorText,
          });
        }

        //----サインインが成功時----
        if (signInResponse == null) {
          await Fluttertoast.showToast(msg: signInSucceededText);
          //uidをuser_auth_providerに格納する
          authViewModel.checkUid();
          //uidをuser_profile_providerに格納する
          profileViewModel.saveUid(authViewModel.uid);
          //メールアドレスが認証されているかをチェックする
          await authViewModel.checkUserEmailVerified();
          //----メールアドレスが認証されているかで遷移先を変更----
          if (authViewModel.userEmailVerified) {
            //await postViewModel.getFollowingUsersPosts();
            //自分のプロフィール情報をFirestoreから取得し、user_profile_providerに格納
            await profileViewModel.getUserProfile(authViewModel.uid);
            print('getUserProfileをしました');
            //UserProfileProviderに入っている情報をデータベースに入れる。
            //appDatabaseにAppDatabaseのインスタンスが現状入っていないため、事前に入れる → AuthPageが表示されたときに格納している
            await localDatabaseViewModel.appDatabase!
                .insertLocalUserProfile(profileViewModel.userProfile);
            print('insertUserBaseProfileをしました');
            //友達の投稿への回答情報をFirestoreから取得する。providerに入れる
            //TODO ここのfirestoreでもエラーが出ている
            await friendsQuizViewModel.getAllPostAnswersFromFirestore();
            //友達の投稿への回答情報をローカルDBに入れる。
            if (friendsQuizViewModel.postAnswers.isNotEmpty) {
              for (var userPostAnswer in friendsQuizViewModel.postAnswers) {
                await localDatabaseViewModel.appDatabase!
                    .insertLocalUserPostAnswer(userPostAnswer);
              }
            }
            print('友達の投稿への処理を実行');
            //TODO 自分の投稿をFirestoreから取得し、post_providerに格納する
            final userPosts =
                await postViewModel.getUserPosts(authViewModel.uid);
            if (userPosts != null) {
              postViewModel.insertPostsToList(userPosts);
              for (var userPost in userPosts) {
                await localDatabaseViewModel.appDatabase!
                    .insertLocalUserPost(userPost);
              }
            }
            //UserProfileProviderに入っている情報をデータベースに入れる。
            //appDatabaseにAppDatabaseのインスタンスが現状入っていないため、事前に入れる → AuthPageが表示されたときに格納している
            await localDatabaseViewModel.appDatabase!
                .insertLocalUserProfile(profileViewModel.userProfile);
            print('insertLocalUserProfileをしました');
            //TODO Firestoreからお気に入りアーティスト情報を取得する
            final userFavoriteArtists =
                await artistFollowViewModel.getUserFavoriteArtists();
            if (userFavoriteArtists != null) {
              artistFollowViewModel.insertArtistsToList(userFavoriteArtists);
              for (var userFavoriteArtist in userFavoriteArtists) {
                await localDatabaseViewModel.appDatabase!
                    .insertLocalUserFavoriteArtist(userFavoriteArtist);
              }
            }
            await followViewModel.getFollowedUsers(profileViewModel.uid);
            await followViewModel.getFollowingUsers(profileViewModel.uid);
            await spotifyViewModel.fetchSpotifyAccessToken();

            if (context.mounted) {
              //この段階では既にAppDatabaseのインスタンスはproviderに格納されている。
              toAfterSignInPage(context: context);
            }
          } else {
            if (context.mounted) {
              toEmailAuthPage(context: context);
            }
            await authViewModel.sendEmailVerification();
          }
        } else {
          authViewModel.refreshFromSignInAndSignOut();
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 100),
          Text(
            signInTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FormFieldItem(
                  autovalidateMode: null,
                  controller: null,
                  onChanged: null,
                  maxLength: maxEmailTextLength,
                  itemName: emailAddressLabel,
                  textRestriction: '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputEmailText;
                    }
                    if (!RegExp(
                      caseSensitive: false,
                      r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
                      //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return inputEmailIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    authViewModel.saveEmail(value as String);
                  },
                ),
                Consumer(builder: (context, ref, _) {
                  authViewModel.setRef(ref);
                  return FormFieldItem(
                    autovalidateMode: null,
                    controller: null,
                    onChanged: null,
                    maxLength: maxPasswordTextLength,
                    itemName: passwordLabel,
                    textRestriction: '',
                    //TODO validatorは緩くする
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return notInputPasswordText;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authViewModel.savePassword(value as String);
                    },
                  );
                }),
                const SizedBox(height: 60),
                //isLoadingでグルグルさせる
                Consumer(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorTheme.color().accentColor,
                    ),
                  ),
                  builder: (context, ref, child) {
                    authViewModel.setRef(ref);
                    profileViewModel.setRef(ref);
                    postViewModel.setRef(ref);
                    localDatabaseViewModel.setRef(ref);
                    friendsQuizViewModel.setRef(ref);
                    artistFollowViewModel.setRef(ref);
                    followViewModel.setRef(ref);
                    spotifyViewModel.setRef(ref);
                    return Visibility(
                      visible: !authViewModel.signInIsLoading,
                      replacement: SizedBox(
                        width: 48,
                        height: 48,
                        child: child,
                      ),
                      child: AccentColorButton(
                        //loadingSignInメソッドをauthViewModelに作成
                        //メールアドレスとパスワードを使って、FirebaseAuthでログインする
                        //メールアドレスが認証されていなかったらメールアドレスを認証する画面を表示させる
                        //ユーザーのプロフィール情報を取得する
                        //completedSignInメソッドをauthViewModelに作成
                        onPressed: () async {
                          authViewModel.loadingSignIn();
                          await signInFunction(formKey, ref);
                          authViewModel.completedSignIn();
                        },
                        text: signInBtnText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                GrayColorTextButton(
                  onPressed: () => toSignUpPage(context: context),
                  text: accountNotExistBtnText,
                ),
                //TODO パスワードを再発行するボタンを作成する
              ],
            ),
          )
        ]),
      ),
    );
  }
}
