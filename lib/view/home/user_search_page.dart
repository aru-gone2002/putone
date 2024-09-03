import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:putone/constants/device_size.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/left_border_text.dart';
import 'package:putone/view/item/main_color_circulalar_text_field.dart';
import 'package:putone/view/item/main_color_circular_button.dart';

class UserSearchPage extends StatelessWidget {
  const UserSearchPage({super.key});

  Future<void> userSearchFunction(String? value) async {
    //TODO ユーザーIDで検索した際の処理を書く。
  }

  @override
  Widget build(BuildContext context) {
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
                      const LeftBorderText(label: userIdLabel),
                      const SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: MainColorCirculalarTextField(
                            itemName: userIdLabel,
                            maxLength: userIdAndUserNameTextLength,
                            onSaved: userSearchFunction,
                            validator: (value) => userIdValidator(value)),
                      ),
                      const SizedBox(height: 40),
                      //メインカラーのボタンを入れる
                      Center(
                        child: MainColorCircularButton(
                          onPressed: () {
                            //TODO 処理を書く
                          },
                          text: searchBtnText,
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
