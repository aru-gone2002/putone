import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/item/title_and_text_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();

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
                    onTap: () => toEditUserNamePage(context: context),
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
                    onTap: () => toEditUserIdPage(context: context),
                    separateCondition: profileViewModel.userId != '');
              },
            ),
            const SizedBox(height: betweenTitleAndTextHeight),
            //テーマソング設定
            Consumer(
              builder: (context, ref, _) {
                profileViewModel.setRef(ref);
                return TitleAndTextButton(
                    inputDataLabel: themeSongLabel,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText:
                        '${profileViewModel.themeMusicName} / ${profileViewModel.themeMusicArtistName}',
                    //TODO テーマソング編集ページに飛ばす
                    onTap: () => toThemeSongSettingPage(context: context),
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
