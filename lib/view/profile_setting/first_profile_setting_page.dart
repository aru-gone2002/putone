import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view_model/profile_view_model.dart';

class FirstProfileSettingPage extends StatelessWidget {
  const FirstProfileSettingPage({super.key});

  void setUserIdAndNameFunction(
      GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
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
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          profileSettingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return FormFieldItem(
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
                      profileViewModel.saveUserId(value as String);
                    },
                  );
                }),
                Consumer(builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return FormFieldItem(
                    itemName: userNameTitle,
                    textRestriction: '',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return notInputUserNameText;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      profileViewModel.saveUserName(value as String);
                    },
                  );
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
        ],
      ),
    );
  }
}
