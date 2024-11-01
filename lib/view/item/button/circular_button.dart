import 'package:flutter/material.dart';
import 'package:putone/constants/height.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.btnColor,
    required this.hasBorder,
    required this.fontColor,
    required this.fontSize,
  });
  final void Function()? onPressed;
  final String text;
  final Color btnColor;
  final bool hasBorder;
  final Color fontColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: colorButtonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: hasBorder ? Colors.black : Colors.transparent,
          ),
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
