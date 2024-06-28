import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class FormFieldItem extends StatelessWidget {
  const FormFieldItem({
    super.key,
    required this.itemName,
    required this.validator,
    required this.onSaved,
  });

  final String itemName;
  final String? Function(String? text) validator;
  final void Function(String? text)? onSaved;

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
            height: 4,
          ),
          TextFormField(
            validator: validator,
            onSaved: onSaved,
            maxLines: 1,
            maxLength: 30,
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
