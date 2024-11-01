import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/local_database.dart';
import 'package:putone/view/item/button/accent_color_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class AdminPage extends ConsumerWidget {
  AdminPage({super.key, required this.database});

  final AppDatabase database;

  final AuthViewModel authViewModel = AuthViewModel();
  final ProfileViewModel profileViewModel = ProfileViewModel();
  final PostViewModel postViewModel = PostViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    authViewModel.setRef(ref);
    profileViewModel.setRef(ref);
    postViewModel.setRef(ref);
    return Scaffold(
      appBar: AppBar(title: Text('Admin')),
      body: AccentColorButton(
          text: 'ログアウトする',
          onPressed: () async {
            await authViewModel.signOut();
            authViewModel.resetUsetAuthProvider();
            profileViewModel.resetUserProfileProvider();
            postViewModel.resetPostProvider();
            postViewModel.resetPostsProvider();
            await database.deleteLocalUserProfile();
            await database.deleteAllLocalUserPosts();
          }),
    );
  }
}
