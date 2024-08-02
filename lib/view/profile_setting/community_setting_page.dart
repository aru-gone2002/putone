import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/community/community.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class CommunitySettingPage extends StatelessWidget {
  const CommunitySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormFieldState>(context);

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
          Consumer(
            builder: (context, ref, child) {
              profileViewModel.setRef(ref);
              return DropdownButtonFormField(
                value: profileViewModel.selectedCommunity,
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
                                  profileViewModel.saveCommunityId(
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
                  profileViewModel.saveSelectedCommunity(value!);
                },
                items: [
                  for (Community value in profileViewModel.communityMap.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(value.communityName),
                    ),
                ],
              );
            },
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
