import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class EmailAuthPage extends ConsumerStatefulWidget {
  const EmailAuthPage({super.key});

  @override
  ConsumerState<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends ConsumerState<EmailAuthPage> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final ProfileViewModel _profileViewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Visibility(
            visible: !_authViewModel.emailAuthIsLoading,
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
                _authViewModel.loadingEmailAuth();
                final signInResponse =
                    await _authViewModel.signInWithEmailAndPassword();

                //　ログインが失敗した時の処理
                if (signInResponse != null && context.mounted) {
                  _authViewModel.completedEmailAuth();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(errorAndRetryText),
                      duration: Duration(milliseconds: 6000),
                    ),
                  );
                }

                //　ログインがちゃんと成功した時の処理
                if (signInResponse == null) {
                  await _authViewModel.checkUserEmailVerified();
                  if (_authViewModel.userEmailVerified) {
                    if (context.mounted) {
                      toFirstProfileSettingPage(context: context);
                      _authViewModel.completedEmailAuth();
                      //追加
                      await _profileViewModel.fetchAccessToken();
                    }
                  } else {
                    await _authViewModel.signOut();
                    if (context.mounted) {
                      _authViewModel.completedEmailAuth();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(emailIsNotVerifiedText),
                          duration: Duration(milliseconds: 6000),
                        ),
                      );
                    }
                  }
                }
              },
              text: isEmailVerifiedText,
            ),
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
