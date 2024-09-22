import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.userProfile,
  });

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toFriendProfilePage(
          context: context,
          userProfile: userProfile,
        );
        print("navigating to profile.");
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColorTheme.color().gray1,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            (userProfile.userImg == '')
                ? ExtendedImage.asset(
                    'assets/images/user_gray_icon.png',
                    width: userImgSmallWidth,
                    height: userImgSmallHeight,
                    shape: BoxShape.circle,
                    fit: BoxFit.cover,
                  )
                : ExtendedImage.network(
                    userProfile.userImg,
                    width: userImgSmallWidth,
                    height: userImgSmallHeight,
                    shape: BoxShape.circle,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: 20),
            Text(
              userProfile.userName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
