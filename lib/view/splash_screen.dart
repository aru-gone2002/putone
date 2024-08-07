import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/theme/app_font_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.color().mainColor,
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: const Alignment(0, -0.05),
            child: Text(
              'PuTone',
              style: AppFontTheme.font(context).logoFont.copyWith(fontSize: 80),
            ),
          ),

          //サブタイトル
          const Align(
            alignment: Alignment(0, 0.1),
            child: Text(
              'Express yourself by music!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      )),
    );
  }
}
