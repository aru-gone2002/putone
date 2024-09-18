import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/quiz_choice/quiz_choice.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/friends_quiz_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ThreeUsersChoices extends ConsumerStatefulWidget {
  const ThreeUsersChoices({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<ThreeUsersChoices> createState() {
    return _ThreeUsersChoicesState();
  }
}

class _ThreeUsersChoicesState extends ConsumerState<ThreeUsersChoices> {
  final FollowViewModel _followViewModel = FollowViewModel();
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final FriendsQuizViewModel _friendsQuizViewModel = FriendsQuizViewModel();

  @override
  void initState() {
    super.initState();
    _followViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? quizChoice1Profile;
    UserProfile? quizChoice2Profile;
    UserProfile? posterProfile;

    //TODO ここでfollowingUsersは取得できていない
    final followingUsers = _followViewModel.followingUsers;
    //やりたい処理としては、followingUsersから自分と投稿主以外のフォローユーザーを取得する
    print('followingUsers: $followingUsers');

    final exceptMeAndPosterFollowingUsers = followingUsers
        .where(
          (followingUser) =>
              //自分じゃないことを検証
              //投稿主じゃないことを検証
              followingUser.followingUid != _profileViewModel.uid &&
              followingUser.followingUid != widget.post.uid,
        )
        .toList();
    print('exceptMeAndPosterFollowingUsers: $exceptMeAndPosterFollowingUsers');

    //TODO 自分と投稿主以外のフォローユーザーから任意で2人を取得する
    Random random = Random();
    int index1 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
    int index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);

    print('index1: $index1');
    print('index2: $index2');

    // 重複を避けるために、異なるインデックスになるまで再生成
    while (index1 == index2) {
      index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
    }

    final quizChoice1Uid = exceptMeAndPosterFollowingUsers[index1].followingUid;
    final quizChoice2Uid = exceptMeAndPosterFollowingUsers[index2].followingUid;

    // TODO uidからそのユーザーのユーザーネームを取得する必要がある
    // final quizChoice1UidProfile = await _friendsQuizViewModel.getQuizUserProfile(quizChoice1Uid);
    // final quizChoice2UidProfile = await _friendsQuizViewModel.getQuizUserProfile(quizChoice2Uid);
    // final posterUidProfile = await _friendsQuizViewModel.getQuizUserProfile(widget.post.uid);

    // // TODO 3択のモデルを作成する
    // final quizChoice1 = QuizChoice(
    //     quizChoiceUid: quizChoice1Uid,
    //     quizChoiceUserName: quizChoice1UidProfile.userName,
    //     quizChoiceUserImg: quizChoice1UidProfile.userImg);
    // final quizChoice2 = QuizChoice(
    //     quizChoiceUid: quizChoice2Uid,
    //     quizChoiceUserName: quizChoice2UidProfile.userName,
    //     quizChoiceUserImg: quizChoice2UidProfile.userImg);
    // final quizChoice3 = QuizChoice(
    //     quizChoiceUid: widget.post.uid,
    //     quizChoiceUserName: posterUidProfile.userName,
    //     quizChoiceUserImg: posterUidProfile.userImg);

    // // TODO 3択のリストを作る
    // List<QuizChoice> quizChoices = [quizChoice1, quizChoice2, quizChoice3];

    // // TODO 3択をシャッフルする
    // quizChoices.shuffle();

    Future<List<QuizChoice>> getThreeUsersChoices() async {
      // //await _followViewModel.getFollowingUsers();
      // final followingUsers = _followViewModel.followingUsers;
      // //やりたい処理としては、followingUsersから自分と投稿主以外のフォローユーザーを取得する
      // print('followingUsers: $followingUsers');

      // final exceptMeAndPosterFollowingUsers = followingUsers
      //     .where(
      //       (followingUser) =>
      //           //自分じゃないことを検証
      //           //投稿主じゃないことを検証
      //           followingUser.uid != _profileViewModel.uid &&
      //           followingUser.uid != widget.post.uid,
      //     )
      //     .toList();
      // print('exceptMeAndPosterFollowingUsers: $exceptMeAndPosterFollowingUsers');

      // //TODO 自分と投稿主以外のフォローユーザーから任意で2人を取得する
      // Random random = Random();
      // int index1 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
      // int index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);

      // // 重複を避けるために、異なるインデックスになるまで再生成
      // while (index1 == index2) {
      //   index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
      // }

      // final quizChoice1Uid = exceptMeAndPosterFollowingUsers[index1].uid;
      // final quizChoice2Uid = exceptMeAndPosterFollowingUsers[index2].uid;

      quizChoice1Profile =
          await _friendsQuizViewModel.getQuizUserProfile(quizChoice1Uid);
      quizChoice2Profile =
          await _friendsQuizViewModel.getQuizUserProfile(quizChoice2Uid);
      posterProfile =
          await _friendsQuizViewModel.getQuizUserProfile(widget.post.uid);

      // TODO 3択のモデルを作成する
      final quizChoice1 = QuizChoice(
        quizChoiceUid: quizChoice1Uid,
        quizChoiceUserName: quizChoice1Profile!.userName,
        quizChoiceUserImg: quizChoice1Profile!.userImg,
      );
      final quizChoice2 = QuizChoice(
        quizChoiceUid: quizChoice2Uid,
        quizChoiceUserName: quizChoice2Profile!.userName,
        quizChoiceUserImg: quizChoice2Profile!.userImg,
      );
      final quizChoice3 = QuizChoice(
        quizChoiceUid: widget.post.uid,
        quizChoiceUserName: posterProfile!.userName,
        quizChoiceUserImg: posterProfile!.userImg,
      );

      // TODO 3択のリストを作る
      List<QuizChoice> quizChoices = [quizChoice1, quizChoice2, quizChoice3];

      // TODO 3択をシャッフルする
      quizChoices.shuffle();

      return quizChoices;
    }

    return FutureBuilder(
        future: getThreeUsersChoices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('何らかのエラーが発生しました'),
            );
          }

          return Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  tileColor: AppColorTheme.color().gray3,
                  leading: snapshot.data![0].quizChoiceUserImg != ''
                      ? ExtendedImage.network(
                          snapshot.data![0].quizChoiceUserImg,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          cache: true,
                        )
                      : ExtendedImage.asset(
                          'assets/images/user_gray_icon.png',
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                        ),
                  title: Text(snapshot.data![0].quizChoiceUserName),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(height: 6),
                ListTile(
                  tileColor: AppColorTheme.color().gray3,
                  leading: snapshot.data![1].quizChoiceUserImg != ''
                      ? ExtendedImage.network(
                          snapshot.data![1].quizChoiceUserImg,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          cache: true,
                        )
                      : ExtendedImage.asset(
                          'assets/images/user_gray_icon.png',
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                        ),
                  title: Text(snapshot.data![1].quizChoiceUserName),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(height: 6),
                ListTile(
                  tileColor: AppColorTheme.color().gray3,
                  leading: snapshot.data![2].quizChoiceUserImg != ''
                      ? ExtendedImage.network(
                          snapshot.data![2].quizChoiceUserImg,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          cache: true,
                        )
                      : ExtendedImage.asset(
                          'assets/images/user_gray_icon.png',
                          width: 40,
                          height: 40,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                        ),
                  title: Text(snapshot.data![2].quizChoiceUserName),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
          );
        });
  }
}
