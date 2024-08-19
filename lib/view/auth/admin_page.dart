import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view_model/auth_view_model.dart';

class AdminPage extends ConsumerWidget {
  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    authViewModel.setRef(ref);
    return Scaffold(
      appBar: AppBar(title: Text('Admin')),
      body: AccentColorButton(
        text: 'ログアウトする',
        onPressed: () => authViewModel.signOut(),
      ),
    );
  }
}
