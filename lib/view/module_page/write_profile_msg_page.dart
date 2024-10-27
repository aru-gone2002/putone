import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/button/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class WriteProfileMsgPage extends StatelessWidget {
  const WriteProfileMsgPage({
    super.key,
    required this.appBarTitle,
    required this.showCurrentProfileMsg,
    required this.onPressed,
    required this.labelText,
  });

  final String appBarTitle;
  final bool showCurrentProfileMsg;
  final void Function(GlobalObjectKey<FormState> formKey, BuildContext context)?
      onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: spaceWidthMedium, vertical: spaceHeightSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: showCurrentProfileMsg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentProfileMsgLabel,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Consumer(builder: (context, ref, _) {
                    profileViewModel.setRef(ref);
                    return Text(
                      profileViewModel.userProfileMsg,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: AppColorTheme.color().gray1,
                          ),
                      softWrap: true,
                    );
                  }),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Text(
              labelText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            Form(
              key: formKey,
              child: Consumer(
                builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return TextFormField(
                    validator: profileMsgValidator,
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
              onPressed: () async => onPressed!(formKey, context),
              text: registerBtnText,
            ),
          ],
        ),
      ),
    );
  }
}
