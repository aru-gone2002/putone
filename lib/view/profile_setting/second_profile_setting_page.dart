import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view/item/title_and_text_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SecondProfileSettingPage extends ConsumerStatefulWidget {
  const SecondProfileSettingPage({super.key});

  @override
  ConsumerState<SecondProfileSettingPage> createState() {
    return _SecondProfileSettingPageState();
  }
}

class _SecondProfileSettingPageState
    extends ConsumerState<SecondProfileSettingPage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
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
                        await _profileViewModel.onImageTapped();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: _profileViewModel.userImg != ''
                                ? NetworkImage(_profileViewModel.userImg)
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
                          '${_profileViewModel.themeMusicName} / ${_profileViewModel.themeMusicArtistName}',
                      //テーマソング設定ページに飛ばす
                      onTap: () => toThemeSongSettingPage(context: context),
                      separateCondition:
                          _profileViewModel.themeMusicName != ''),
                  const SizedBox(height: 40),
                  //コミュニティ設定
                  TitleAndTextButton(
                    inputDataLabel: belongCommunityLabel,
                    separateCondition: _profileViewModel.communityId != '',
                    beforeInputText: tapForSettingBtnText,
                    //TODO
                    //communityMap[_profileViewModel.communityId]では初期値ではnullが返されてしまう。
                    //そのため、そのプロパティを取るとnull safetyによってエラーが発生してしまう。
                    //それを防ぐためには、対策を取る必要がある。
                    //TODO ここは改善する必要がある
                    afterInputText: _profileViewModel
                                .communityMap[_profileViewModel.communityId] ==
                            null
                        ? ''
                        : _profileViewModel
                            .communityMap[_profileViewModel.communityId]!
                            .communityName,
                    //コミュニティ設定ページに飛ばす
                    onTap: () => toCommunitySettingPage(context: context),
                  ),
                  const SizedBox(height: 40),
                  //プロフィール文設定
                  TitleAndTextButton(
                      inputDataLabel: profileTitle,
                      beforeInputText: tapForSettingBtnText,
                      afterInputText: _profileViewModel.userProfileMsg,

                      //プロフィール文設定ページに飛ばす
                      onTap: () => toProfileMsgSettingPage(context: context),
                      separateCondition:
                          _profileViewModel.userProfileMsg != ''),
                ],
              ),
              const SizedBox(height: 120),
              AccentColorButton(
                //TODO 処理を追加する
                //プロフィールをFirestoreとFirebaseに追加する
                //routeを設定する
                onPressed: () async {
                  toProfilePage(context: context);
                  await _profileViewModel.uploadProfileInfo();
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
