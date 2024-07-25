import 'package:flutter/material.dart';
import 'package:putone/theme/app_color_theme.dart';

class TitleAndTextButton extends StatelessWidget {
  const TitleAndTextButton({
    super.key,
    required this.inputDataLabel,
    required this.beforeInputText,
    required this.afterInputText,
    required this.onTap,
    required this.separateCondition,
  });

  final String inputDataLabel;
  final String beforeInputText;
  final String afterInputText;
  final void Function() onTap;
  final bool separateCondition;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: deviceWidth * 0.9),
      child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inputDataLabel,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              separateCondition
                  ? Text(afterInputText)
                  : Text(
                      beforeInputText,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColorTheme.color().gray1),
                    ),
            ],
          )),
    );
  }
}
