import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spaceWidthMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 48),
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
                          radius: 72,
                          //child: _profileViewModel.userImg == '' ? nil : ,
                          backgroundImage: _profileViewModel.userImg != ''
                              ? NetworkImage(_profileViewModel.userImg)
                              : null,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          registerProfileImgText,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                //テーマソング設定
                TitleAndTextButton(
                    inputDataLabel: themeSongTitle,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText:
                        '${_profileViewModel.themeMusicArtistName} / ${_profileViewModel.themeMusicArtistName}',
                    //TODO 処理を追加
                    //テーマソング設定ページに飛ばす
                    onTap: () {
                      toThemeSongSettingPage(context: context);
                    },
                    separateCondition: _profileViewModel.themeMusicName != ''),
                const SizedBox(height: 40),
                //プロフィール文設定
                TitleAndTextButton(
                    inputDataLabel: profileTitle,
                    beforeInputText: tapForSettingBtnText,
                    afterInputText: _profileViewModel.userProfileMsg,
                    //TODO 処理を追加
                    //プロフィール文設定ページに飛ばす
                    onTap: () {},
                    separateCondition: _profileViewModel.userProfileMsg != ''),
              ],
            ),
            const SizedBox(height: 120),
            AccentColorButton(
              //TODO 処理を追加する
              onPressed: () {},
              text: nextProgressBtnText,
            ),
            const SizedBox(height: 32),
            DeepGrayButton(onPressed: () {}, text: skipBtnText),
          ],
        ),
      ),
    );
  }
}
