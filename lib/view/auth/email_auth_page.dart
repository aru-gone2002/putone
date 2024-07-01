import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';

class EmailAuthPage extends ConsumerStatefulWidget {
  const EmailAuthPage({super.key});

  @override
  ConsumerState<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends ConsumerState<EmailAuthPage> {
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
    //_authViewModel.checkUserEmailVerified();
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
            child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  const Text(reSignUpText),
                  GrayColorTextButton(
                    onPressed: () {
                      toSignUpPage(context: context);
                    },
                    text: signupTitle,
                  ),
                ],
              );
            }
            return AccentColorButton(
                onPressed: () async {
                  await _authViewModel.checkUserEmailVerified();
                  //メールアドレスが認証されていたら、ボタンを押した時にプロフィール設定画面に飛ぶ
                  //メールアドレスが認証されていないかったら、
                  //ボタンを押した時にメールアドレスが認証されているか再度確認し、
                  //再び認証されていなかったらsnackBarを投げる。
                  //初期値はfalseのため、認証されているか確認される。
                  if (_authViewModel.userEmailVerified) {
                    if (context.mounted) {
                      toFirstProfileSettingPage(context: context);
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(emailIsNotVerifiedText)),
                      );
                    }
                  }
                },
                text: isEmailVerifiedText);
          },
        )),
        const SizedBox(height: 48),
        GrayColorTextButton(
            onPressed: () async {
              //TODO ログアウトの処理
              await _authViewModel.signOut();
              if (context.mounted) {
                toSignUpPage(context: context);
              }
            },
            text: missEmailAndreSignUpText),
        const Expanded(child: SizedBox()),
      ]),
    );
  }
}
