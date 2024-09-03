import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class LeftBorderText extends StatelessWidget {
  const LeftBorderText({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 24,
          width: 7,
          decoration: BoxDecoration(
            color: AppColorTheme.color().mainColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
