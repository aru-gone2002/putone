import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view_model/profile_view_model.dart';

class FirstProfileSettingPage extends ConsumerStatefulWidget {
  const FirstProfileSettingPage({super.key});

  @override
  ConsumerState<FirstProfileSettingPage> createState() {
    return _FirstProfileSettingPageState();
  }
}

class _FirstProfileSettingPageState
    extends ConsumerState<FirstProfileSettingPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProfileViewModel _profileViewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
  }

  void setUserIdAndNameFunction(
      GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      //_profileViewModel.getAndSaveUid();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(userIdAndNameCompleteSnackBarText),
        ),
      );
      toSecondProfileSettingPage(context: context);
    }
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 32),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormFieldItem(
                  itemName: userIdTitle,
                  textRestriction: userIdRestrictionText,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputUserIdText;
                    }
                    //小文字と.と数字で入力してもらうようにする。正規表現のやつ
                    if (!RegExp(r'^[a-z0-9.]{4,}$').hasMatch(value)) {
                      return inputUserIdIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profileViewModel.saveUserId(value as String);
                  }),
              FormFieldItem(
                  itemName: userNameTitle,
                  textRestriction: '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputUserNameText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profileViewModel.saveUserName(value as String);
                  }),
              const SizedBox(height: 60),
              AccentColorButton(
                onPressed: () {
                  //FirestoreにユーザーIDとユーザー名が入力したいが、
                  //まずはproviderに値を入れてから、最後にFirestoreに入れる。
                  //場所はFirebaseAuthのコレクションに入れる
                  setUserIdAndNameFunction(formKey, context);
                },
                text: nextProgressBtnText,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
