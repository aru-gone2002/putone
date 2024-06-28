import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: deviceHeight * 0.1),
        Text(
          signupTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormFieldItem(itemName: emailAddressTitle),
              const FormFieldItem(itemName: passwordTitle),
              // const FormInputItem(
              //   inputItem: 'メールアドレス',
              //   savedItemValue: InputItemValue.signupEmail,
              //   maxLength: 30,
              // ),
              // const SizedBox(height: 8),
              // const FormInputItem(
              //   inputItem: 'パスワード',
              //   savedItemValue: InputItemValue.signUpPassword,
              //   maxLength: 20,
              // ),
              const SizedBox(height: 60),
              SingUpButton(formKey: formKey),
              const SizedBox(height: 32),
              const MoveToLoginPageButton(),
            ],
          ),
        )
      ]),
    );
  }
}

class SingUpButton extends ConsumerStatefulWidget {
  const SingUpButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<SingUpButton> createState() {
    return _SingUpButtonState();
  }
}

class _SingUpButtonState extends ConsumerState<SingUpButton> {
  //final AuthViewModel _authViewModel = AuthViewModel();
  //bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    //_authViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return AccentColorButton(onPressed: () {}, text: signupTitle);
  }
}

class MoveToLoginPageButton extends ConsumerStatefulWidget {
  const MoveToLoginPageButton({
    super.key,
  });

  @override
  ConsumerState<MoveToLoginPageButton> createState() {
    return _MoveToLoginPageButtonState();
  }
}

class _MoveToLoginPageButtonState extends ConsumerState<MoveToLoginPageButton> {
  @override
  Widget build(BuildContext context) {
    return GrayColorTextButton(
      onPressed: () {},
      text: accountExistText,
    );
  }
}
