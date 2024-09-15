import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/after_signIn_page.dart';
import 'package:putone/data/community/community.dart';
import 'package:putone/data/followed_user/followed_user.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/auth/email_auth_page.dart';
import 'package:putone/view/edit_profile/edit_user_id_page.dart';
import 'package:putone/view/edit_profile/edit_user_name_page.dart';
import 'package:putone/view/home/user_search_page.dart';
import 'package:putone/view/post/post_add_msg_page.dart';
import 'package:putone/view/edit_profile/edit_profile_page.dart';
import 'package:putone/view/profile/follow_list_screen.dart';
import 'package:putone/view/profile/friend_profile_page.dart';
import 'package:putone/view/profile/profile_page.dart';
import 'package:putone/view/module_page/select_community_page.dart';
import 'package:putone/view/profile_setting/first_profile_setting_page.dart';
import 'package:putone/view/auth/signin_page.dart';
import 'package:putone/view/module_page/write_profile_msg_page.dart';
import 'package:putone/view/profile_setting/second_profile_setting_page.dart';
import 'package:putone/view/auth/signup_page.dart';
import 'package:putone/view/module_page/select_song_page.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:putone/data/user_profile/user_profile.dart';

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

void toWriteProfileMsgPage({
  required BuildContext context,
  required String appBarTitle,
  required bool showCurrentProfileMsg,
  required void Function(
          GlobalObjectKey<FormState> formKey, BuildContext context)?
      onPressed,
  required String labelText,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => WriteProfileMsgPage(
              appBarTitle: appBarTitle,
              showCurrentProfileMsg: showCurrentProfileMsg,
              onPressed: onPressed,
              labelText: labelText,
            )),
      ),
    );

void toSelectCommunityPage({
  required BuildContext context,
  required void Function(Community? community)? onPressed,
  required String appBarTitle,
  required bool showCurrentCommunity,
  required String btnText,
  required String labelText,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => SelectCommunityPage(
              onPressed: onPressed,
              appBarTitle: appBarTitle,
              showCurrentCommunity: showCurrentCommunity,
              btnText: btnText,
              labelText: labelText,
            )),
      ),
    );

void toProfilePage({
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => const ProfilePage()),
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

void toAfterSignInPage({
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => const AfterSignInPage()),
    ),
  );
}

void toUserSearchPage({
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => const UserSearchPage()),
    ),
  );
}

void toFollowListPage({
  required BuildContext context,
  required List<FollowingUser> followingUsers,
  required List<FollowedUser> followedUsers,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => FollowListScreen(
            followingUsers: followingUsers,
            followedUsers: followedUsers,
          )),
    ),
  );
}

void toFriendProfilePage({
  required BuildContext context,
  required UserProfile userProfile,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => FriendProfilePage(userProfile: userProfile)),
    ),
  );
}
