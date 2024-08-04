import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/auth/auth_page.dart';
import 'package:putone/view/profile_page/profile_page.dart';
import 'package:putone/view/splash_screen.dart';

class PuTone extends StatelessWidget {
  const PuTone({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const ProfilePage();
          }
          return const AuthPage();
        },
      ),
    );
  }
}
