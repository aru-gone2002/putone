import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class SmallColorButton extends StatelessWidget {
  const SmallColorButton({
    super.key,
    required this.btntext,
    required this.onPressed,
    required this.backgroundColor,
  });

  final String btntext;
  final void Function()? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        btntext,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
