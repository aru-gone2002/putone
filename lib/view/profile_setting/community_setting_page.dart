import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/community/community.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class CommunitySettingPage extends ConsumerStatefulWidget {
  const CommunitySettingPage({super.key});

  @override
  ConsumerState<CommunitySettingPage> createState() {
    return _CommunitySettingPageState();
  }
}

class _CommunitySettingPageState extends ConsumerState<CommunitySettingPage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          communityPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: spaceWidthMedium, vertical: spaceHeightSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            selectedCommunityLabel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            value: _profileViewModel.selectedCommunity,
            validator: (value) {
              if (value == null) {
                return askSelectCommunityValidator;
              }
              return null;
            },
            key: formKey,
            onSaved: (value) async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(communitySettingConfirmDialogText),
                      content: Text(
                        value!.communityName,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(backBtnText),
                        ),
                        TextButton(
                            child: const Text(registerBtnText),
                            onPressed: () {
                              //ProfileのproviderにcommunityIdを保存する
                              _profileViewModel.saveCommunityId(
                                value.communityId,
                              );
                              //ダイアログを閉じる
                              Navigator.pop(context);
                              //コミュニティの登録画面を閉じる
                              Navigator.pop(context);
                            }),
                      ],
                    );
                  });
            },
            onChanged: (value) {
              _profileViewModel.saveSelectedCommunity(value!);
            },
            items: [
              for (Community value in _profileViewModel.communityMap.values)
                DropdownMenuItem(
                  value: value,
                  child: Text(value.communityName),
                ),
            ],
          ),
          const SizedBox(height: 80),
          DeepGrayButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              }
            },
            text: registerBtnText,
          ),
        ]),
      ),
    );
  }
}
