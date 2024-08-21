import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/local_database.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    authViewModel.setRef(ref);
    profileViewModel.setRef(ref);

    return Drawer(
      child: ListView(
        children: [
          InkWell(
            child: const ListTile(
              title: Text(signOutBtnText),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(askwhetherSignOutOrNotDialogTitle),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(backBtnText),
                      ),
                      TextButton(
                        onPressed: () async {
                          //TODO ローカルDBを削除する
                          //引数のUserBaseProfileはUserBaseProfilesの中身の1つであるから、
                          //getAllUserBaseProfilesメソッドで取得して、.firstメソッドで入れる
                          //or Streamでやる
                          //or 最初に取ってきたデータベースを捨てるか
                          Navigator.pop(context);
                          Navigator.pop(context);
                          toAuthPage(context: context);
                          await authViewModel.signOut();
                          // await profileViewModel.appDatabase!
                          //     .deleteUserBaseProfile();
                          authViewModel.resetUsetAuthProvider();
                          profileViewModel.resetUserProfileProvider();
                          database.deleteLocalUserProfile();
                          database.deleteAllLocalUserPosts();
                        },
                        child: const Text(signOutBtnText),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}