import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view/item/title_and_text_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SecondProfileSettingPage extends ConsumerWidget {
  const SecondProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    profileViewModel.setRef(ref);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          profileSettingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spaceWidthMedium, vertical: spaceHeightMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await profileViewModel.onImageTapped();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
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
                    ),
                  ),
                  const SizedBox(height: 64),
                  //テーマソング設定
                  TitleAndTextButton(
                      inputDataLabel: themeSongLabel,
                      beforeInputText: tapForSettingBtnText,
                      afterInputText:
                          '${profileViewModel.themeMusicName} / ${profileViewModel.themeMusicArtistName}',
                      //テーマソング設定ページに飛ばす
                      onTap: () => toThemeSongSettingPage(context: context),
                      separateCondition: profileViewModel.themeMusicName != ''),
                  const SizedBox(height: 40),
                  //コミュニティ設定
                  TitleAndTextButton(
                    inputDataLabel: belongCommunityLabel,
                    separateCondition: profileViewModel.communityId != '',
                    beforeInputText: tapForSettingBtnText,
                    //TODO
                    //communityMap[_profileViewModel.communityId]では初期値ではnullが返されてしまう。
                    //そのため、そのプロパティを取るとnull safetyによってエラーが発生してしまう。
                    //それを防ぐためには、対策を取る必要がある。
                    //TODO ここは改善する必要がある
                    afterInputText: profileViewModel
                                .communityMap[profileViewModel.communityId] ==
                            null
                        ? ''
                        : profileViewModel
                            .communityMap[profileViewModel.communityId]!
                            .communityName,
                    //コミュニティ設定ページに飛ばす
                    onTap: () => toCommunitySettingPage(context: context),
                  ),
                  const SizedBox(height: 40),
                  //プロフィール文設定
                  TitleAndTextButton(
                      inputDataLabel: profileTitle,
                      beforeInputText: tapForSettingBtnText,
                      afterInputText: profileViewModel.userProfileMsg,

                      //プロフィール文設定ページに飛ばす
                      onTap: () => toProfileMsgSettingPage(context: context),
                      separateCondition: profileViewModel.userProfileMsg != ''),
                ],
              ),
              const SizedBox(height: 120),
              AccentColorButton(
                //TODO 処理を追加する
                //プロフィールをFirestoreとFirebaseに追加する
                //routeを設定する
                onPressed: () async {
                  toProfilePage(context: context);
                  await profileViewModel.uploadProfileInfo();
                },
                text: nextProgressBtnText,
              ),
              const SizedBox(height: 32),
              DeepGrayButton(
                onPressed: () {
                  toProfilePage(context: context);
                },
                text: skipBtnText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
