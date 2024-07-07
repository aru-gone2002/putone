import 'package:flutter/material.dart';

class AppColorTheme {
  const AppColorTheme({
    required this.mainColor,
    required this.accentColor,
    required this.gray1,
    required this.gray2,
  });

  final Color mainColor;
  final Color accentColor;
  final Color gray1;
  final Color gray2;

  factory AppColorTheme.color() => const AppColorTheme(
        mainColor: Color.fromARGB(255, 255, 184, 0),
        accentColor: Color.fromARGB(255, 39, 162, 187),
        gray1: Color.fromARGB(255, 164, 164, 164),
        gray2: Color.fromARGB(255, 59, 59, 59),
      );
}
