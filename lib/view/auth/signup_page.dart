import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthViewModel authViewModel = AuthViewModel();
    final formKey = GlobalObjectKey<FormState>(context);
    authViewModel.setRef(ref);

    Future<void> signUpFunction(GlobalObjectKey<FormState> formKey) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //firebase Authでメールアドレスとパスワードを使ってサインアップし、
        //メールアドレス認証メールを送る処理を実行
        final signUpResponse = await authViewModel.signUpWithEmailAndPassword();
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

        if (context.mounted && signUpResponse == null) {
          toEmailAuthPage(context: context);
        }
      }
    }

    return Scaffold(
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
                  textRestriction: '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputEmailText;
                    }
                    if (!RegExp(
                      caseSensitive: false,
                      r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
                      //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return inputEmailIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    authViewModel.saveEmail(value as String);
                  },
                ),
                FormFieldItem(
                  itemName: passwordTitle,
                  textRestriction: passwordRestrictionText,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputPasswordText;
                    }
                    if (!RegExp(r'^[a-zA-Z0-9\W]{8,}$')
                        // r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
                        .hasMatch(value)) {
                      return inputPasswordIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    authViewModel.savePassword(value as String);
                  },
                ),
                const SizedBox(height: 60),
                //　isLoadingでグルグルさせる
                Visibility(
                  visible: !authViewModel.signUpIsLoading,
                  replacement: SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColorTheme.color().accentColor,
                      ),
                    ),
                  ),
                  child: AccentColorButton(
                    onPressed: () async {
                      authViewModel.loadingSignUp();
                      await signUpFunction(formKey);
                      authViewModel.completedSignUp();
                    },
                    text: signupTitle,
                  ),
                ),
                const SizedBox(height: 32),
                GrayColorTextButton(
                  onPressed: () {},
                  text: accountExistText,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
