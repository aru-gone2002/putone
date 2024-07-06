import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class AccentColorButton extends StatelessWidget {
  const AccentColorButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48,
        minWidth: deviceWidth * 0.9,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorTheme.color().accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
