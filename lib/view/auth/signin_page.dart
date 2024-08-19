import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final formKey = GlobalObjectKey<FormState>(context);

    Future<void> signInFunction(
        GlobalObjectKey<FormState> formKey, WidgetRef ref) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        //firebase Authでメールアドレスとパスワードを使ってサインインする
        //isSignInをtrueにする。
        final signInResponse = await authViewModel.signInWithEmailAndPassword();

        if (signInResponse is FirebaseAuthException) {
          await Fluttertoast.showToast(
              msg: switch (signInResponse.code) {
            'invalid-email' || 'user-disabled' => invalidEmailText,
            'user-not-found' => userNotFoundText,
            'wrong-password' => wrongPasswordText,
            _ => signInErrorText,
          });
        }

        //サインインが成功したか確認する
        if (signInResponse == null) {
          await Fluttertoast.showToast(msg: signInSucceededText);
          //uidをuser_auth_providerに格納する
          authViewModel.checkUid();
          //uidをuser_profile_providerに格納する
          profileViewModel.saveUid(authViewModel.uid);
          //メールアドレスが認証されているかをチェックする
          await authViewModel.checkUserEmailVerified();
          //メールアドレスが認証されているかで遷移先を変更
          if (authViewModel.userEmailVerified) {
            //自分のプロフィール情報を取得し、user_profile_providerに格納
            await profileViewModel.getUserProfile(authViewModel.uid);
            print('getUserProfileをしました');
            //TODO UserProfileProviderに入っている情報をデータベースに入れる。
            //TODO appDatabaseにAppDatabaseのインスタンスが現状入っていないため、事前に入れる → AuthPageが表示されたときに格納している
            await profileViewModel.appDatabase!
                .insertLocalUserProfile(profileViewModel.userProfile);
            print('insertUserBaseProfileをしました');
            if (context.mounted) {
              //この段階では既にAppDatabaseのインスタンスはproviderに格納されている。
              toProfilePage(context: context, ref: ref);
            }
          } else {
            if (context.mounted) {
              toEmailAuthPage(context: context);
            }
            await authViewModel.sendEmailVerification();
          }
        } else {
          authViewModel.refreshFromSignInAndSignOut();
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 100),
          Text(
            signInTitle,
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
                  itemName: emailAddressLabel,
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
                Consumer(builder: (context, ref, _) {
                  authViewModel.setRef(ref);
                  return FormFieldItem(
                    itemName: passwordLabel,
                    textRestriction: '',
                    //TODO validatorは緩くする
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return notInputPasswordText;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authViewModel.savePassword(value as String);
                    },
                  );
                }),
                const SizedBox(height: 60),
                //isLoadingでグルグルさせる
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
                      visible: !authViewModel.signInIsLoading,
                      replacement: SizedBox(
                        width: 48,
                        height: 48,
                        child: child,
                      ),
                      child: AccentColorButton(
                        //loadingSignInメソッドをauthViewModelに作成
                        //メールアドレスとパスワードを使って、FirebaseAuthでログインする
                        //メールアドレスが認証されていなかったらメールアドレスを認証する画面を表示させる
                        //ユーザーのプロフィール情報を取得する
                        //completedSignInメソッドをauthViewModelに作成
                        onPressed: () async {
                          authViewModel.loadingSignIn();
                          await signInFunction(formKey, ref);
                          authViewModel.completedSignIn();
                        },
                        text: signInBtnText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                GrayColorTextButton(
                  onPressed: () => toSignUpPage(context: context),
                  text: accountNotExistBtnText,
                ),
                //TODO パスワードを再発行するボタンを作成する
              ],
            ),
          )
        ]),
      ),
    );
  }
}
