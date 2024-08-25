import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/auth/email_auth_page.dart';
import 'package:putone/view/edit_profile/edit_user_id_page.dart';
import 'package:putone/view/edit_profile/edit_user_name_page.dart';
import 'package:putone/view/post/post_add_msg_page.dart';
import 'package:putone/view/edit_profile/edit_profile_page.dart';
import 'package:putone/view/profile/profile_page.dart';
import 'package:putone/view/profile_setting/community_setting_page.dart';
import 'package:putone/view/profile_setting/first_profile_setting_page.dart';
import 'package:putone/view/auth/signin_page.dart';
import 'package:putone/view/profile_setting/profile_msg_setting_page.dart';
import 'package:putone/view/profile_setting/second_profile_setting_page.dart';
import 'package:putone/view/auth/signup_page.dart';
import 'package:putone/view/module_page/select_song_page.dart';
import 'package:putone/view_model/local_database_view_model.dart';
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

void toSelectSongPage({
  required BuildContext context,
  required String appBarTitle,
  required void Function(SpotifyTrack spotifyTrack) onTap,
  required bool isVisibleCurrentMusicInfo,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => SelectSongPage(
              appBarTitle: appBarTitle,
              onTap: onTap,
              isVisibleCurrentMusicInfo: isVisibleCurrentMusicInfo,
            )),
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
  final LocalDatabaseViewModel localDatabaseViewModel =
      LocalDatabaseViewModel();
  localDatabaseViewModel.setRef(ref);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) =>
          ProfilePage(database: localDatabaseViewModel.appDatabase!)),
    ),
  );
}

void toAuthPage({required BuildContext context}) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const AuthPage()),
      ),
    );

void toPostAddMsgPage({
  required BuildContext context,
  required SpotifyTrack selectedTrack,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => PostAddMsgPage(
              selectedTrack: selectedTrack,
            )),
      ),
    );

void toEditProfilePage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const EditProfilePage()),
      ),
    );

void toEditUserNamePage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const EditUserNamePage()),
      ),
    );

void toEditUserIdPage({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const EditUserIdPage()),
      ),
    );
