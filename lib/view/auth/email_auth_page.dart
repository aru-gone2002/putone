import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                    authViewModel.fromSignIn();
                    //TODO ここでsnapshot.hasDataが発火してしまうため、対応が必要
                    final signInResponse =
                        await authViewModel.signInWithEmailAndPassword();

                    //　ログインが失敗した時の処理（裏での処理）
                    if (signInResponse != null) {
                      await authViewModel.signOut();
                      authViewModel.completedEmailAuth();
                      authViewModel.refreshFromSignIn();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(errorAndRetryText),
                            duration: Duration(milliseconds: 6000),
                          ),
                        );
                      }
                    }

                    //　ログインがちゃんと成功した時の処理
                    if (signInResponse == null) {
                      await authViewModel.checkUserEmailVerified();
                      if (authViewModel.userEmailVerified) {
                        if (context.mounted) {
                          toFirstProfileSettingPage(context: context);
                          authViewModel.completedEmailAuth();
                          await profileViewModel.fetchSpotifyAccessToken();
                        }
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
