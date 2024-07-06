import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class GrayColorTextButton extends StatelessWidget {
  const GrayColorTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColorTheme.color().gray1,
              ),
        ));
  }
}
