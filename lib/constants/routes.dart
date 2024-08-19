import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/auth/email_auth_page.dart';
import 'package:putone/view/profile_page/profile_page.dart';
import 'package:putone/view/profile_setting/community_setting_page.dart';
import 'package:putone/view/profile_setting/first_profile_setting_page.dart';
import 'package:putone/view/auth/signin_page.dart';
import 'package:putone/view/profile_setting/profile_msg_setting_page.dart';
import 'package:putone/view/profile_setting/second_profile_setting_page.dart';
import 'package:putone/view/auth/signup_page.dart';
import 'package:putone/view/profile_setting/theme_song_setting_page.dart';
import 'package:putone/view_model/profile_view_model.dart';

void toEmailAuthPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const EmailAuthPage()),
      ),
    );

void toFirstProfileSettingPage({required BuildContext context}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const FirstProfileSettingPage()),
      ),
    );

void toSignUpPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const SignUpPage()),
      ),
    );

void toSignInPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const SignInPage()),
      ),
    );

void toSecondProfileSettingPage({required BuildContext context}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const SecondProfileSettingPage()),
      ),
    );

void toThemeSongSettingPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const ThemeSongSettingPage()),
      ),
    );

void toProfileMsgSettingPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const ProfileMsgSettingPage()),
      ),
    );

void toCommunitySettingPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const CommunitySettingPage()),
      ),
    );

void toProfilePage({required BuildContext context, required WidgetRef ref}) {
  final ProfileViewModel profileViewModel = ProfileViewModel();
  profileViewModel.setRef(ref);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) =>
          ProfilePage(database: profileViewModel.appDatabase!)),
    ),
  );
}

void toAuthPage({required BuildContext context}) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const AuthPage()),
      ),
    );
