import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/device_size.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/left_border_text.dart';
import 'package:putone/view/item/main_color_circulalar_text_field.dart';
import 'package:putone/view/item/circular_button.dart';
import 'package:putone/view_model/user_search_view_model.dart';

class UserSearchPage extends StatelessWidget {
  const UserSearchPage({super.key});

  Widget searchUserDisplay({
    required UserProfile userProfile,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColorTheme.color().mainColor,
        border: Border.all(
          width: 2,
          color: AppColorTheme.color().mainColor,
        ),
      ),
      width: DeviceSize.screenWidthWithPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              userSearchTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeftBorderText(
                    label: resultOfSearchUserLabel,
                    borderColor: AppColorTheme.color().mainColor,
                  ),
                  const SizedBox(height: 16),
                  //TODO ここに検索結果を表示する
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: userProfile.userImg != ''
                        ? ExtendedImage.network(
                            userProfile.userImg,
                            width: userImgMediumWidth,
                            height: userImgMediumHeight,
                            fit: BoxFit.cover,
                            cache: true,
                            shape: BoxShape.circle,
                          )
                        : ExtendedImage.asset(
                            'assets/images/user_gray_icon.png',
                            width: userImgMediumWidth,
                            height: userImgMediumHeight,
                            shape: BoxShape.circle,
                            fit: BoxFit.cover,
                          ),
                    title: Text(
                      userProfile.userName,
                    ),
                    subtitle: Text(userProfile.userId),
                  ),
                  const SizedBox(height: 40),
                  //メインカラーのボタンを入れる
                  Center(
                    child: CircularButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: backBtnText,
                      btnColor: AppColorTheme.color().mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> userSearchFunction({
    required String? value,
    required UserSearchViewModel userSearchViewModel,
    required BuildContext context,
  }) async {
    //検索ボタンがグルグルするようにする
    userSearchViewModel.searchingUser();

    //ユーザーIDで検索した際の処理を書く。
    final result = await userSearchViewModel.searchUserByUserId(value!);
    if (result is UserProfile) {
      //TODO 検索結果を表示する
      print('ユーザー検索結果：$result');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: [
                searchUserDisplay(userProfile: result, context: context),
              ],
            );
          },
        );
      }
    }
    if (result == 'no_account') {
      Fluttertoast.showToast(
          msg: '$valueに該当するアカウントが\n見つかりませんでした。',
          toastLength: Toast.LENGTH_LONG);
    }
    if (result == 'error') {
      Fluttertoast.showToast(
          msg: '検索中に何らかのエラーが発生しました', toastLength: Toast.LENGTH_LONG);
    }
    //検索ボタンのグルグルが止まるようにする
    userSearchViewModel.completedSearchingUser();
  }

  @override
  Widget build(BuildContext context) {
    final UserSearchViewModel userSearchViewModel = UserSearchViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userSearchPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColorTheme.color().mainColor,
            border: Border.all(
              width: 2,
              color: AppColorTheme.color().mainColor,
            ),
          ),
          width: DeviceSize.screenWidthWithPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  userSearchTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LeftBorderText(
                        label: userIdLabel,
                        borderColor: AppColorTheme.color().mainColor,
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: MainColorCirculalarTextField(
                            itemName: userIdLabel,
                            maxLength: userIdAndUserNameTextLength,
                            onSaved: (value) => userSearchFunction(
                                  context: context,
                                  value: value,
                                  userSearchViewModel: userSearchViewModel,
                                ),
                            validator: (value) => userIdValidator(value)),
                      ),
                      const SizedBox(height: 40),
                      //メインカラーのボタンを入れる
                      Center(
                        child: Consumer(
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColorTheme.color().accentColor,
                              ),
                            ),
                          ),
                          builder: (context, ref, child) {
                            userSearchViewModel.setRef(ref);
                            return Visibility(
                              visible: !userSearchViewModel.isUserSearching,
                              replacement: child!,
                              child: CircularButton(
                                onPressed: () {
                                  //TODO 処理を書く
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                  }
                                },
                                text: searchBtnText,
                                btnColor: AppColorTheme.color().mainColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
