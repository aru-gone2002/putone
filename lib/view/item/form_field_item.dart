import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class FormFieldItem extends StatelessWidget {
  const FormFieldItem({
    super.key,
    required this.itemName,
    required this.textRestriction,
    required this.validator,
    required this.onSaved,
    required this.maxLength,
    required this.controller,
    required this.autovalidateMode,
  });

  final String itemName;
  final String textRestriction;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final int maxLength;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48, maxWidth: deviceWidth * 0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: 2,
          ),
          if (textRestriction != '')
            Text(
              textRestriction,
              style:
                  TextStyle(fontSize: 14, color: AppColorTheme.color().gray1),
            ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            maxLines: 1,
            maxLength: maxLength,
            cursorColor: AppColorTheme.color().mainColor,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              isDense: true,
              hintText: '$itemNameを入力',
              hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColorTheme.color().gray1,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColorTheme.color().gray1,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColorTheme.color().mainColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
