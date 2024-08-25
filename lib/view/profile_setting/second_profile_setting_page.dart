import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view/item/title_and_text_button.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SecondProfileSettingPage extends StatelessWidget {
  const SecondProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();

    Future<void> setThemeSongFunction(SpotifyTrack spotifySearchTrack) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(setThemeMusicConfirmDialogText),
            content: Text(
                //providerに入ったリストの中身をindexで取ってきたものがspotifySearchTrack
                '${spotifySearchTrack.trackName} / ${spotifySearchTrack.artistName}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(backBtnText),
              ),
              TextButton(
                  child: const Text(registerBtnText),
                  onPressed: () {
                    profileViewModel.setThemeSong(track: spotifySearchTrack);
                    //ダイアログを閉じる
                    Navigator.pop(context);
                    //テーマソングの登録画面を閉じる
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          profileSettingAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceWidthMedium, vertical: spaceHeightMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Consumer(
                      builder: (context, ref, _) {
                        profileViewModel.setRef(ref);
                        return InkWell(
                          onTap: () async {
                            await profileViewModel.onImageTapped();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: profileSetttingUserImgRadiusWidth,
                                backgroundImage: profileViewModel.userImg != ''
                                    ? NetworkImage(profileViewModel.userImg)
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                registerProfileImgText,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                      height: betweenUserImgAndOtherProfileInfoHeight),
                  //テーマソング設定
                  Consumer(
                    builder: (context, ref, _) {
                      profileViewModel.setRef(ref);
                      return TitleAndTextButton(
                          inputDataLabel: themeSongLabel,
                          beforeInputText: tapForSettingBtnText,
                          afterInputText:
                              '${profileViewModel.themeMusicName} / ${profileViewModel.themeMusicArtistName}',
                          //テーマソング設定ページに飛ばす
                          onTap: () => toSelectSongPage(
                              context: context,
                              appBarTitle: themeSongSettingPageAppbarTitle,
                              onTap: setThemeSongFunction,
                              isVisibleCurrentMusicInfo: true),
                          separateCondition:
                              profileViewModel.themeMusicName != '');
                    },
                  ),
                  const SizedBox(height: betweenTitleAndTextHeight),
                  //コミュニティ設定
                  Consumer(
                    builder: (context, ref, _) {
                      profileViewModel.setRef(ref);
                      return TitleAndTextButton(
                        inputDataLabel: belongCommunityLabel,
                        separateCondition:
                            profileViewModel.communityId != 'none',
                        beforeInputText: tapForSettingBtnText,
                        //TODO
                        //communityMap[_profileViewModel.communityId]では初期値ではnullが返されてしまう。
                        //そのため、そのプロパティを取るとnull safetyによってエラーが発生してしまう。
                        //それを防ぐためには、対策を取る必要がある。
                        afterInputText: profileViewModel
                            .communityMap[profileViewModel.communityId]!
                            .communityName,
                        //コミュニティ設定ページに飛ばす
                        onTap: () => toCommunitySettingPage(context: context),
                      );
                    },
                  ),
                  const SizedBox(height: betweenTitleAndTextHeight),
                  //プロフィール文設定
                  Consumer(
                    builder: (context, ref, child) {
                      profileViewModel.setRef(ref);
                      return TitleAndTextButton(
                          inputDataLabel: profileTitle,
                          beforeInputText: tapForSettingBtnText,
                          afterInputText: profileViewModel.userProfileMsg,

                          //プロフィール文設定ページに飛ばす
                          onTap: () =>
                              toProfileMsgSettingPage(context: context),
                          separateCondition:
                              profileViewModel.userProfileMsg != '');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 120),
              Consumer(builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                localDatabaseViewModel.setRef(ref);
                return AccentColorButton(
                  //プロフィールをFirestoreとFirebaseに追加する
                  //routeを設定する
                  onPressed: () async {
                    toProfilePage(context: context, ref: ref);
                    await profileViewModel.setUserProfileToFirestore();
                    //ローカルDBにデータを入れる処理を行う。
                    //updateの形に変更する
                    await localDatabaseViewModel.appDatabase!
                        .updateLocalUserProfile(profileViewModel.userProfile);
                    //コミュニティが入力されていたら、コミュニティにそのユーザーを追加する機能を実装する
                    if (profileViewModel.communityId != 'none') {
                      await profileViewModel.addUserToCommunity();
                    }
                  },
                  text: nextProgressBtnText,
                );
              }),
              const SizedBox(height: 32),
              Consumer(builder: (context, ref, _) {
                return DeepGrayButton(
                  onPressed: () {
                    toProfilePage(context: context, ref: ref);
                  },
                  text: skipBtnText,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
