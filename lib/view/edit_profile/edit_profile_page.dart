import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/view/item/title_and_text_button.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();

    //テーマソングを変更する際の関数を書く
    Future<void> editThemeSongFunction(SpotifyTrack spotifyTrack) async {
      await showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: const Text(editThemeMusicConfirmDialogText),
            content: Text(
                //providerに入ったリストの中身をindexで取ってきたものがspotifySearchTrack
                '${spotifyTrack.trackName} / ${spotifyTrack.artistName}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(backBtnText),
              ),
              TextButton(
                  child: const Text(registerBtnText),
                  onPressed: () async {
                    //UserProfileProviderの値を変更する
                    profileViewModel.saveThemeMusicImg(spotifyTrack.trackImg);
                    profileViewModel.saveThemeMusicName(spotifyTrack.trackName);
                    profileViewModel
                        .saveThemeMusicArtistName(spotifyTrack.artistName);
                    profileViewModel.saveThemeMusicSpotifyUrl(
                        spotifyTrack.trackExternalUrl);
                    profileViewModel.saveThemeMusicPreviewUrl(
                        spotifyTrack.previewUrl ?? '');

                    //ローカルDBの値を変更する
                    await localDatabaseViewModel.appDatabase!
                        .updateLocalThemeMusicInfo(
                      uid: profileViewModel.uid,
                      newThemeMusicArtistName: spotifyTrack.artistName,
                      newThemeMusicName: spotifyTrack.trackName,
                      newThemeMusicImg: spotifyTrack.trackImg,
                      newThemeMusicSpotifyUrl: spotifyTrack.trackExternalUrl,
                      newThemeMusicPreviewUrl: spotifyTrack.previewUrl ?? '',
                    );

                    //Firestoreの値を変更する
                    await profileViewModel.updateFirestoreThemeMusicInfo(
                        spotifyTrack: spotifyTrack);
                    //ダイアログを閉じる
                    if (context.mounted) {
                      Navigator.pop(context);
                      //テーマソングの登録画面を閉じる
                      Navigator.pop(context);
                    }
                  }),
            ],
          );
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editProfileAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: spaceWidthMedium,
          right: spaceHeightMedium,
          top: spaceHeightSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //プロフィール画像の編集
            Center(
              child: Consumer(
                builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return InkWell(
                    onTap: () async {
                      await profileViewModel.onImageTapped();
                      //ローカルDBのuserImgを変更する
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
            const SizedBox(height: 56),
            //ユーザー名の編集
            Consumer(
              builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                return TitleAndTextButton(
                    inputDataLabel: userNameLabel,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText: profileViewModel.userName,
                    //ユーザー名編集ページに飛ばす
                    onTap: () => toEditUserNamePage(context: context),
                    //toThemeSongSettingPage(context: context),
                    separateCondition: profileViewModel.userName != '');
              },
            ),
            const SizedBox(height: betweenTitleAndTextHeight),
            //ユーザーIDの編集
            Consumer(
              builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                return TitleAndTextButton(
                    inputDataLabel: userIdLabel,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText: profileViewModel.userId,
                    //TODO ユーザーID編集ページに飛ばす
                    onTap: () => toEditUserIdPage(context: context),
                    //toThemeSongSettingPage(context: context),
                    separateCondition: profileViewModel.userId != '');
              },
            ),
            const SizedBox(height: betweenTitleAndTextHeight),
            //テーマソング設定
            Consumer(
              builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                localDatabaseViewModel.setRef(ref);
                return TitleAndTextButton(
                    inputDataLabel: themeSongLabel,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText:
                        '${profileViewModel.themeMusicName} / ${profileViewModel.themeMusicArtistName}',
                    //テーマソング編集ページに飛ばす
                    onTap: () => toSelectSongPage(
                          context: context,
                          appBarTitle: '',
                          onTap: editThemeSongFunction,
                          isVisibleCurrentMusicInfo: true,
                        ),
                    separateCondition: profileViewModel.themeMusicName != '');
              },
            ),
            const SizedBox(height: betweenTitleAndTextHeight),
            //コミュニティ設定
            Consumer(
              builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                return TitleAndTextButton(
                  inputDataLabel: belongCommunityLabel,
                  separateCondition: profileViewModel.communityId != 'none',
                  beforeInputText: tapForSettingBtnText,
                  //TODO
                  //communityMap[_profileViewModel.communityId]では初期値ではnullが返されてしまう。
                  //そのため、そのプロパティを取るとnull safetyによってエラーが発生してしまう。
                  //それを防ぐためには、対策を取る必要がある。
                  afterInputText: profileViewModel
                      .communityMap[profileViewModel.communityId]!
                      .communityName,
                  //TODO コミュニティ編集ページに飛ばす
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

                    //TODO プロフィール文編集ページに飛ばす
                    onTap: () => toProfileMsgSettingPage(context: context),
                    separateCondition: profileViewModel.userProfileMsg != '');
              },
            ),
          ],
        ),
      ),
    );
  }
}
