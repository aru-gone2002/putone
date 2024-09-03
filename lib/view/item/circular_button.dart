import 'package:flutter/material.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.btnColor,
  });
  final void Function()? onPressed;
  final String text;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: colorButtonHeight,
      width: mainColorButtonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
