import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    //final deviceHeight = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 100),
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
                FormFieldItem(
                  itemName: emailAddressTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'メールアドレスが入力されていません';
                    }
                    if (!RegExp(
                      caseSensitive: false,
                      r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
                      //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return '正しいメールアドレスを入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authViewModel.saveEmail(value as String);
                  },
                ),
                FormFieldItem(
                  itemName: passwordTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'パスワードが入力されていません';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9\W]{8,}$')
                        // r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
                        .hasMatch(value)) {
                      return '8文字以上で半角英数字記号をそれぞれ一文字以上ずつ入れてください';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authViewModel.savePassword(value as String);
                  },
                ),
                const SizedBox(height: 60),
                SignUpButton(formKey: formKey),
                const SizedBox(height: 32),
                const MoveToLoginPageButton(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<SignUpButton> createState() {
    return _SignUpButtonState();
  }
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return AccentColorButton(
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            print('会員登録ページのvaidatorクリア');
            widget.formKey.currentState!.save();
            //firebase Authでメールアドレスとパスワードを使ってサインアップし、
            //メールアドレス認証メールを送る処理を実行
            final signUpResponse =
                await _authViewModel.signUpWithEmailAndPassword();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: signUpResponse == null
                        ? const Text(signUpSucceededText)
                        : switch (signUpResponse.code) {
                            'weak-password' => const Text(weakPasswordText),
                            'email-already-in-use' =>
                              const Text(emailAlreadyInUseText),
                            'invalid-email' => const Text(invalidEmailText),
                            _ => const Text(accountCreateErrorText),
                          }),
              );
            }
            final signInResponse =
                await _authViewModel.signInWithEmailAndPassword();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: signInResponse == null
                        ? const Text(signInSucceededText)
                        : switch (signInResponse.code) {
                            'invalid-email' ||
                            'user-disabled' =>
                              const Text(invalidEmailText),
                            'user-not-found' => const Text(userNotFoundText),
                            'wrong-password' => const Text(wrongPasswordText),
                            _ => const Text(loginErrorText),
                          }),
              );
            }
            if (context.mounted) {
              toEmailAuthPage(context: context);
            }
          }
        },
        text: signupTitle);
  }
}

class MoveToLoginPageButton extends StatelessWidget {
  const MoveToLoginPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GrayColorTextButton(
      onPressed: () {},
      text: accountExistText,
    );
  }
}
