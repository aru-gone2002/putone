import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileSettingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 48),
        Form(
          key: formKey,
          child: Column(
            children: [
              FormFieldItem(
                  itemName: userIdTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputUserIdText;
                    }
                    //小文字と.と_と数字で入力してもらうようにする。正規表現のやつ
                    if (RegExp(r'^[a-z0-9._]{4,}$').hasMatch(value)) {
                      return inputUserIdIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profileViewModel.saveUserId(value as String);
                  }),
              FormFieldItem(
                  itemName: userNameTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputUserNameText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profileViewModel.saveUserName(value as String);
                  }),
            ],
          ),
        )
      ]),
    );
  }
}
