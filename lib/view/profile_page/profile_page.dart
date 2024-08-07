import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view_model/auth_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Column(
        children: [
          Center(
            child: Text('プロフィール画面'),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              child: const ListTile(
                title: Text('ログアウトする'),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('ログアウトしますか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(backBtnText),
                        ),
                        Consumer(
                            child: const Text('ログアウトする'),
                            builder: (context, ref, child) {
                              authViewModel.setRef(ref);
                              return TextButton(
                                onPressed: () async {
                                  await authViewModel.signOut();
                                  //TODO Navigator.popをasyncの中で使わない方法を考える
                                  Navigator.pop(context);
                                },
                                child: child!,
                              );
                            }),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
