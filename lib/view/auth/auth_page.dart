import 'package:flutter/material.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/theme/app_font_theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.color().mainColor,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            //ロゴ
            Align(
              alignment: const Alignment(0, -0.2),
              child: Text(
                'PuTone',
                style:
                    AppFontTheme.font(context).logoFont.copyWith(fontSize: 80),
              ),
            ),

            //サブタイトル
            const Align(
              alignment: Alignment(0, 0),
              child: Text(
                'Express yourself by music!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            //ログインボタン
            Align(
              alignment: const Alignment(0, 0.6),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48, minWidth: 300),
                child: ElevatedButton(
                  onPressed: () => toSignInPage(context: context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    signInBtnText,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            //新規会員登録ボタン
            Align(
              alignment: const Alignment(0, 0.75),
              child: TextButton(
                onPressed: () => toSignUpPage(context: context),
                child: const Text(
                  signUpBtnText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
