import 'package:flutter/material.dart';

class AppColorTheme {
  const AppColorTheme({
    required this.mainColor,
    required this.accentColor,
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.correctColor,
    required this.wrongColor,
  });

  final Color mainColor;
  final Color accentColor;
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color correctColor;
  final Color wrongColor;

  factory AppColorTheme.color() => const AppColorTheme(
        mainColor: Color.fromARGB(255, 255, 184, 0),
        accentColor: Color.fromARGB(255, 39, 162, 187),
        gray1: Color.fromARGB(255, 164, 164, 164),
        gray2: Color.fromARGB(255, 59, 59, 59),
        gray3: Color.fromARGB(255, 242, 242, 242),
        correctColor: Color.fromARGB(255, 255, 226, 152),
        wrongColor: Color.fromARGB(255, 126, 199, 213),
      );
}
