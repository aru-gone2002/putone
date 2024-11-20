import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class MainColorCirculalarTextField extends StatelessWidget {
  const MainColorCirculalarTextField({
    super.key,
    required this.itemName,
    required this.maxLength,
    required this.onSaved,
    required this.validator,
  });

  final String itemName;
  final String? Function(String? text) validator;
  final void Function(String? text)? onSaved;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      maxLines: 1,
      maxLength: maxLength,
      cursorColor: AppColorTheme.color().mainColor,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: 'Enter $itemName',
        hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColorTheme.color().gray1,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColorTheme.color().mainColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColorTheme.color().mainColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
