import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/auth/login_page.dart';
import 'package:putone/view/item/accent_color_button.dart';

class EmailAuthPage extends StatelessWidget {
  const EmailAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;

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
          child: AccentColorButton(
              onPressed: () {
                toFirstProfileSettingPage(context: context);
              },
              text: progressFirstProfileSettingText),
        ),
        const Expanded(child: SizedBox()),
      ]),
    );
    // StreamBuilder(
    //     stream: FirebaseAuth.instance.userChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Scaffold(
    //           body: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 const SizedBox(height: 100),
    //                 Text(
    //                   signupTitle,
    //                   textAlign: TextAlign.center,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headlineLarge!
    //                       .copyWith(fontWeight: FontWeight.bold),
    //                 ),
    //                 const SizedBox(height: 300),
    //                 Center(
    //                   child: Text(
    //                     emailAuthConfirmText,
    //                     style: Theme.of(context).textTheme.labelMedium,
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //                 const Expanded(child: SizedBox()),
    //               ]),
    //         );
    //       }
    //       if (snapshot.hasData) {
    //         print('StreamBuilderのデータ取得');
    //         if (snapshot.data!.emailVerified) {
    //           print('emailVerified取得');
    //           return const LoginPage();
    //         }
    //       }
    //       return const AuthPage();
    //     });
  }
}
