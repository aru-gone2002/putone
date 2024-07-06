import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppFontTheme {
  const AppFontTheme({
    required this.logoFont,
  });

  final TextStyle logoFont;

  factory AppFontTheme.font(context) => AppFontTheme(
        logoFont: GoogleFonts.carterOne(
          textStyle: Theme.of(context).textTheme.titleLarge,
          color: Colors.white,
          fontSize: 26,
        ),
      );
}

class AppFontSizeTheme {
  const AppFontSizeTheme({
    required this.middle1,
  });
  final double middle1;

  factory AppFontSizeTheme.fontSize() => const AppFontSizeTheme(
        middle1: 18,
      );
}
