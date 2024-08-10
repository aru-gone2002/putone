import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:putone/database.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/profile_page/profile_page.dart';
import 'package:putone/view/splash_screen.dart';
import 'package:putone/view_model/profile_view_model.dart';

class PuTone extends StatelessWidget {
  const PuTone({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();

    return MaterialApp(
      title: 'PuTone',
      theme: ThemeData(
        indicatorColor: AppColorTheme.color().mainColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorTheme.color().mainColor,
          elevation: 0,
        ),
        fontFamily: 'NotoSans',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontSize: 16),
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, _) {
        profileViewModel.setRef(ref);
        //TODO エラーの箇所
        //profileViewModel.saveAppDatabase(database);

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              Future(
                () async {
                  profileViewModel.saveAppDatabase(database);
                  //ローカルDBからデータを取得
                  final userBaseProfiles =
                      await database.getAllUserBaseProfiles();
                  final userBaseProfile = userBaseProfiles.first;
                  //userBaseProfileの内容をproviderに入れる
                  profileViewModel.saveUserProfileLocalDBData(userBaseProfile);
                },
              );
              return const ProfilePage();
            }
            return const AuthPage();
          },
        );
      }),
    );
  }
}
