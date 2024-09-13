import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/follow_view_model.dart';

class FollowButton extends ConsumerStatefulWidget {
  const FollowButton({
    super.key,
    required this.followingUser,
  });

  final FollowingUser followingUser;

  @override
  ConsumerState<FollowButton> createState() {
    return _FollowButtonState();
  }
}

class _FollowButtonState extends ConsumerState<FollowButton> {
  late bool isFollowing;
  final FollowViewModel followViewModel = FollowViewModel();

  @override
  void initState() {
    super.initState();
    followViewModel.setRef(ref);
    //followViewModel.getFollowingUsers();
    isFollowing = followViewModel.followingUsers
        .where(
          (followingUser) =>
              widget.followingUser.followingUid == followingUser.followingUid,
        )
        .toList()
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final followingUser = widget.followingUser;

    return ElevatedButton(
      onPressed: () async {
        //TODO 新しくフォローする時の処理
        if (isFollowing == false) {
          //providerにフォローしたユーザーを新たに加える
          //Firestoreにフォローするユーザーのドキュメントを追加する
          await followViewModel.followUser(followingUser: followingUser);
          setState(() {
            isFollowing = followViewModel.followingUsers
                .where(
                  (followingUser) =>
                      widget.followingUser.followingUid ==
                      followingUser.followingUid,
                )
                .toList()
                .isNotEmpty;
          });
        } else {
          //TODO 既にフォローしていたときの処理
          //providerからアンフォローするユーザーを削除する
          //Firestoreからアンフォローするユーザーのドキュメントを削除する
          await followViewModel.unfollowUser(
              followingUid: followingUser.followingUid);
          setState(() {
            isFollowing = followViewModel.followingUsers
                .where(
                  (followingUser) =>
                      widget.followingUser.followingUid ==
                      followingUser.followingUid,
                )
                .toList()
                .isNotEmpty;
          });
        }
      },
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
      child: Text((!isFollowing) ? followBtnText : followingBtnText),
    );
  }
}
