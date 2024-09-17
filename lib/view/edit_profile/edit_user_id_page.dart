import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class EditUserIdPage extends ConsumerStatefulWidget {
  const EditUserIdPage({super.key});

  @override
  ConsumerState<EditUserIdPage> createState() => _EditUserIdPageState();
}

class _EditUserIdPageState extends ConsumerState<EditUserIdPage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final LocalDatabaseViewModel _localDatabaseViewModel =
      LocalDatabaseViewModel();
  final TextEditingController _userIdController = TextEditingController();
  dynamic _userIdValidationMsg;

  Future<void> uploadEdittedUserId(String? value) async {
    //providerのuserIdの変更
    _profileViewModel.saveUserId(value!);
    //ローカルDBのuserIdの変更
    await _localDatabaseViewModel.appDatabase!
        .updateLocalUserId(uid: _profileViewModel.uid, newUserId: value);
    //FirestoreのuserIdの変更
    await _profileViewModel.updateFirestoreUserId(newUserId: value);
  }

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
    _localDatabaseViewModel.setRef(ref);
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
        title: Text(
          editUserIdAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spaceWidthMedium,
          vertical: spaceHeightSmall,
        ),
        child: Column(children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              currentUserIdLabel,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              _profileViewModel.userId,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColorTheme.color().gray1),
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: formKey,
            child: FormFieldItem(
              controller: _userIdController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              itemName: afterChangedUserIdLabel,
              textRestriction: userIdRestrictionText,
              validator: (value) => _userIdValidationMsg,
              onSaved: (value) async => uploadEdittedUserId(value),
              maxLength: userIdAndUserNameTextLength,
              onChanged: (value) async {
                _userIdValidationMsg = await userIdValidator(
                    _userIdController.text, _profileViewModel);
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 80),
          DeepGrayButton(
            onPressed: () async {
              _userIdValidationMsg = await userIdValidator(
                  _userIdController.text, _profileViewModel);
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }
            },
            text: changeBtnText,
          ),
        ]),
      ),
    );
  }
}
