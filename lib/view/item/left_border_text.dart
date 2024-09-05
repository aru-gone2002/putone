import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class LeftBorderText extends StatelessWidget {
  const LeftBorderText({
    super.key,
    required this.label,
    required this.borderColor,
    required this.borderHeight,
    required this.fontSize,
    required this.labelAndLabelSpace,
  });

  final String label;
  final Color borderColor;
  final double borderHeight;
  final double fontSize;
  final double labelAndLabelSpace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: borderHeight,
          width: 7,
          decoration: BoxDecoration(
            color: AppColorTheme.color().mainColor,
          ),
        ),
        SizedBox(width: labelAndLabelSpace),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
      ],
    );
  }
}
