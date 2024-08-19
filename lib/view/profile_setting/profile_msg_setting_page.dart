import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ProfileMsgSettingPage extends StatelessWidget {
  const ProfileMsgSettingPage({super.key});

  void setUserProfileMsgFunction(
      GlobalObjectKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(profileMsgSavedSnackBarText),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileMsgSettingPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: spaceWidthMedium, vertical: spaceHeightSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileMsgLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            Form(
              key: formKey,
              child: Consumer(
                builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return notInputTextValidator;
                      }
                      if (value.length > maxProfileTextLength) {
                        return askTextLengthLessThanOrEqual80Validator;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      profileViewModel.saveUserProfileMsg(value!);
                    },
                    maxLines: 5,
                    maxLength: maxProfileTextLength,
                    //expands: true,
                    cursorColor: AppColorTheme.color().mainColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      isDense: true,
                      hintText: profileMsgHintText,
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: AppColorTheme.color().gray1,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColorTheme.color().gray1,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColorTheme.color().mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            DeepGrayButton(
                onPressed: () => setUserProfileMsgFunction(formKey, context),
                text: registerBtnText),
          ],
        ),
      ),
    );
  }
}
