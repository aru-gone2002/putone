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

class EditUserIdPage extends ConsumerWidget {
  const EditUserIdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    profileViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);
    final formKey = GlobalObjectKey<FormState>(context);

    Future<void> uploadEdittedUserId(String? value) async {
      //providerのuserIdの変更
      profileViewModel.saveUserId(value!);
      //ローカルDBのuserIdの変更
      await localDatabaseViewModel.appDatabase!
          .updateLocalUserId(uid: profileViewModel.uid, newUserId: value);
      //FirestoreのuserIdの変更
      await profileViewModel.updateFirestoreUserId(newUserId: value);
    }

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
              profileViewModel.userId,
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
              itemName: afterChangedUserIdLabel,
              textRestriction: userIdRestrictionText,
              validator: (value) => userIdValidator(
                  value: value, profileViewModel: profileViewModel),
              onSaved: (value) async => uploadEdittedUserId(value),
              maxLength: userIdAndUserNameTextLength,
            ),
          ),
          const SizedBox(height: 80),
          DeepGrayButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            text: changeBtnText,
          ),
        ]),
      ),
    );
  }
}
