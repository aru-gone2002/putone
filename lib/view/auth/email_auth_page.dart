import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class EmailAuthPage extends StatelessWidget {
  const EmailAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 100),
        Text(
          signupTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 240),
        Text(
          emailAuthConfirmText,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 200),
        Center(
          child: Consumer(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColorTheme.color().accentColor,
              ),
            ),
            builder: (context, ref, child) {
              authViewModel.setRef(ref);
              profileViewModel.setRef(ref);
              return Visibility(
                visible: !authViewModel.emailAuthIsLoading,
                replacement: SizedBox(
                  width: 48,
                  height: 48,
                  child: child,
                ),
                child: AccentColorButton(
                  onPressed: () async {
                    authViewModel.loadingEmailAuth();
                    //認証が終わっていない場合、SignInページからAuthPageに来る場合もあるため、こちらでも行っておく
                    //TODO ここでsnapshot.hasDataが発火してしまうため、対応が必要
                    final signInResponse =
                        await authViewModel.signInWithEmailAndPassword();

                    //　サインインが失敗した時の処理（裏での処理）
                    if (signInResponse != null) {
                      await authViewModel.signOut();
                      authViewModel.completedEmailAuth();
                      Fluttertoast.showToast(msg: errorAndRetryText);
                      // if (context.mounted) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text(errorAndRetryText),
                      //       duration: Duration(milliseconds: 6000),
                      //     ),
                      //   );
                      // }
                    }

                    //　サインインがちゃんと成功した時の処理
                    if (signInResponse == null) {
                      await authViewModel.checkUserEmailVerified();
                      if (authViewModel.userEmailVerified) {
                        //TODO uidをUserAuthProviderとUserProfileProviderに入れ、ローカルDBに格納する
                        authViewModel.checkUid();
                        profileViewModel.saveUid(authViewModel.uid);
                        profileViewModel.saveUserId(authViewModel.uid);
                        profileViewModel.saveUserName(authViewModel.uid);
                        //TODO appDataBaseProvider経由でローカルDBに格納する。ちょっと危険かも？
                        profileViewModel.appDatabase!.insertLocalUserProfile(
                            profileViewModel.userProfile);
                        //TODO Firestoreに入れるのもこのタイミングでいいんじゃない？
                        if (context.mounted)
                          toFirstProfileSettingPage(context: context);
                        authViewModel.completedEmailAuth();
                        await profileViewModel.fetchSpotifyAccessToken();
                      }
                    }
                  },
                  text: isEmailVerifiedText,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 48),
        GrayColorTextButton(
            onPressed: () {
              toSignUpPage(context: context);
            },
            text: missEmailAndreSignUpText),
      ]),
    );
  }
}
