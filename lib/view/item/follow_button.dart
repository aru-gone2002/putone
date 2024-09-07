import 'package:flutter/material.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';

class FollowButton extends StatelessWidget {
  FollowButton({
    super.key,
    required this.isFollowing,
  });

  bool isFollowing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        isFollowing = !isFollowing;
      },
      label: Text((!isFollowing) ? 'フォロー' : 'フォロー中'),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 6),
        backgroundColor: (!isFollowing)
            ? AppColorTheme.color().accentColor
            : AppColorTheme.color().gray1,
        foregroundColor: Colors.white,
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
      ),
    );
  }
}
