import 'package:flutter/material.dart';
import 'package:putone/constants/device_size.dart';
import 'package:putone/constants/height.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: colorButtonHeight,
        minWidth: DeviceSize.screenWidth * 0.9,
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
