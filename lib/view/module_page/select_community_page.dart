import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/community/community.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/button/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SelectCommunityPage extends StatelessWidget {
  const SelectCommunityPage({
    super.key,
    required this.onPressed,
    required this.appBarTitle,
    required this.showCurrentCommunity,
    required this.btnText,
    required this.labelText,
  });

  final void Function(Community? community)? onPressed;
  final String appBarTitle;
  final bool showCurrentCommunity;
  final String btnText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormFieldState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: spaceWidthMedium, vertical: spaceHeightSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Visibility(
            visible: showCurrentCommunity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentCommunityLabel,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Consumer(builder: (context, ref, _) {
                  profileViewModel.setRef(ref);
                  return Text(
                    profileViewModel.communityMap[profileViewModel.communityId]!
                        .communityName,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColorTheme.color().gray1,
                        ),
                    overflow: TextOverflow.ellipsis,
                  );
                }),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Text(
            labelText,
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
                onSaved: onPressed,
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
            text: btnText,
          ),
        ]),
      ),
    );
  }
}
