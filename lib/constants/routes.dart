import 'package:flutter/material.dart';
import 'package:putone/view/auth/email_auth_page.dart';
import 'package:putone/view/profile/first_profile_setting_page.dart';
import 'package:putone/view/auth/login_page.dart';
import 'package:putone/view/profile/profile_msg_setting_page.dart';
import 'package:putone/view/profile/second_profile_setting_page.dart';
import 'package:putone/view/auth/signup_page.dart';
import 'package:putone/view/profile/theme_song_setting_page.dart';

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

void toLoginPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const LoginPage()),
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
