import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/view/item/button/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view_model/profile_view_model.dart';

class FirstProfileSettingPage extends ConsumerStatefulWidget {
  const FirstProfileSettingPage({super.key});

  @override
  ConsumerState<FirstProfileSettingPage> createState() =>
      _FirstProfileSettingPageState();
}

class _FirstProfileSettingPageState
    extends ConsumerState<FirstProfileSettingPage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final TextEditingController _userIdController = TextEditingController();
  dynamic _userIdValidationMsg;

  Future<void> setUserIdAndNameFunction(
      GlobalKey<FormState> formKey, BuildContext context) async {
    // final isUserIdAvailable = await _profileViewModel
    //     .checkUserIdIdenticication(_userIdController.text);
    _userIdValidationMsg =
        await userIdValidator(_userIdController.text, _profileViewModel);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Fluttertoast.showToast(msg: userIdAndNameCompleteToastText);
      if (context.mounted) {
        toSecondProfileSettingPage(context: context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          profileSettingAppbarTitle,
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
                FormFieldItem(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _userIdController,
                  maxLength: userIdAndUserNameTextLength,
                  itemName: userIdLabel,
                  textRestriction: userIdRestrictionText,
                  validator: (value) => _userIdValidationMsg,
                  onSaved: (value) {
                    _profileViewModel.saveUserId(value as String);
                  },
                  onChanged: (value) async {
                    //TODO ここでvalidator的なことをして、validatorに返す値を取得する。
                    // final isUserIdAvailable = await _profileViewModel
                    //     .checkUserIdIdenticication(_userIdController.text);
                    _userIdValidationMsg = await userIdValidator(
                        _userIdController.text, _profileViewModel);
                    setState(() {});
                  },
                ),
                FormFieldItem(
                  autovalidateMode: null,
                  onChanged: null,
                  controller: null,
                  maxLength: userIdAndUserNameTextLength,
                  itemName: userNameLabel,
                  textRestriction: '',
                  validator: (value) => userNameValidator(value),
                  onSaved: (value) {
                    _profileViewModel.saveUserName(value as String);
                  },
                ),
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
          ),
        ],
      ),
    );
  }
}
