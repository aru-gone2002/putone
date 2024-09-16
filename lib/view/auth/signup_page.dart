import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    Future<void> signUpFunction(GlobalObjectKey<FormState> formKey) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //firebase Authでメールアドレスとパスワードを使ってサインアップし、
        //メールアドレス認証メールを送る処理を実行
        //fromSignInAndSignUpを実行し、snapshot.hasDataが起きないようにする
        final signUpResponse = await authViewModel.signUpWithEmailAndPassword();

        if (signUpResponse is UserCredential) {
          final responseUid = signUpResponse.user!.uid;
          authViewModel.saveUid(responseUid);
          profileViewModel.saveUid(responseUid);
          profileViewModel.saveUserId(responseUid);
          profileViewModel.saveUserName(responseUid);

          await profileViewModel.setUserProfileToFirestore();
          await Fluttertoast.showToast(msg: signUpSucceededText);
          await authViewModel.sendEmailVerification();

          if (context.mounted) toEmailAuthPage(context: context);
        }

        if (signUpResponse is FirebaseException) {
          await Fluttertoast.showToast(
              msg: switch (signUpResponse.code) {
            'weak-password' => weakPasswordText,
            'email-already-in-use' => emailAlreadyInUseText,
            'invalid-email' => invalidEmailText,
            _ => accountCreateErrorText,
          });
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
                  onChanged: null,
                  autovalidateMode: null,
                  controller: null,
                  maxLength: maxEmailTextLength,
                  itemName: emailAddressLabel,
                  textRestriction: '',
                  validator: (value) => emailValidator(value),
                  onSaved: (value) {
                    authViewModel.saveEmail(value as String);
                  },
                ),
                Consumer(builder: (context, ref, _) {
                  authViewModel.setRef(ref);
                  return FormFieldItem(
                    onChanged: null,
                    autovalidateMode: null,
                    controller: null,
                    maxLength: maxPasswordTextLength,
                    itemName: passwordLabel,
                    textRestriction: passwordRestrictionText,
                    validator: (value) => passwordValidator(value),
                    onSaved: (value) {
                      authViewModel.savePassword(value as String);
                    },
                  );
                }),
                const SizedBox(height: 60),
                //　isLoadingでグルグルさせる
                Consumer(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorTheme.color().accentColor,
                    ),
                  ),
                  builder: (context, ref, child) {
                    authViewModel.setRef(ref);
                    profileViewModel.setRef(ref);
                    return Visibility(
                      visible: !authViewModel.signUpIsLoading,
                      replacement: SizedBox(
                        width: 48,
                        height: 48,
                        child: child,
                      ),
                      child: AccentColorButton(
                        onPressed: () async {
                          authViewModel.loadingSignUp();
                          await signUpFunction(formKey);
                          authViewModel.completedSignUp();
                        },
                        text: signupTitle,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                GrayColorTextButton(
                  onPressed: () => toSignInPage(context: context),
                  text: accountExistBtnText,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
