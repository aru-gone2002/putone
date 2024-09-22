import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/data/quiz_choice/quiz_choice.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/friends_quiz_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ThreeUsersChoices extends ConsumerWidget {
  const ThreeUsersChoices({super.key, required this.post});

  final Post post;

  Future<void> answerOnPressed({
    required ProfileViewModel profileViewModel,
    required FriendsQuizViewModel friendsQuizViewModel,
    required LocalDatabaseViewModel localDatabaseViewModel,
    required UserProfile posterProfile,
    required QuizChoice quizChoice,
    required String quizChoice1Uid,
    required UserProfile quizChoice1Profile,
    required UserProfile quizChoice2Profile,
    required String quizChoice2Uid,
  }) async {
    // 選択したユーザーを取得する
    // FirestoreにpostAnswersを追加する
    final postAnswer = PostAnswer(
      postId: post.postId,
      replyUid: profileViewModel.uid,
      posterUid: post.uid,
      posterUserName: posterProfile!.userName,
      posterUserImg: posterProfile!.userImg,
      replyUserId: profileViewModel.userId,
      replyUserName: profileViewModel.userName,
      replyUserImg: profileViewModel.userImg,
      answerUid: quizChoice.quizChoiceUid,
      quizChoice1Uid: quizChoice1Uid,
      quizChoice1UserName: quizChoice1Profile!.userName,
      quizChoice1UserImg: quizChoice1Profile!.userImg,
      quizChoice2Uid: quizChoice2Uid,
      quizChoice2UserName: quizChoice2Profile!.userName,
      quizChoice2UserImg: quizChoice2Profile!.userImg,
      answerTimestamp: DateTime.now(),
    );

    await friendsQuizViewModel.sendPostAnswerToFirestore(
      postAnswer: postAnswer,
    );

    // ローカルDBに格納する
    await localDatabaseViewModel.appDatabase!
        .insertLocalUserPostAnswer(postAnswer);

    // providerに格納
    friendsQuizViewModel.addPostAnswers(postAnswer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FollowViewModel followViewModel = FollowViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final FriendsQuizViewModel friendsQuizViewModel = FriendsQuizViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();
    followViewModel.setRef(ref);
    profileViewModel.setRef(ref);
    friendsQuizViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);
    UserProfile? quizChoice1Profile;
    UserProfile? quizChoice2Profile;
    UserProfile? posterProfile;

    final followingUsers = followViewModel.followingUsers;

    //自分と投稿者以外のフォロー中ユーザーのuidを取得する
    final exceptMeAndPosterFollowingUsers = followingUsers
        .where(
          (followingUser) =>
              //自分じゃないことを検証
              //投稿主じゃないことを検証
              followingUser.followingUid != profileViewModel.uid &&
              followingUser.followingUid != post.uid,
        )
        .toList();

    //自分と投稿主以外のフォローユーザーから任意で2人を取得する
    Random random = Random();
    int index1 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
    int index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);

    // 重複を避けるために、異なるインデックスになるまで再生成
    while (index1 == index2) {
      index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
    }

    final quizChoice1Uid = exceptMeAndPosterFollowingUsers[index1].followingUid;
    final quizChoice2Uid = exceptMeAndPosterFollowingUsers[index2].followingUid;

    Future<List<QuizChoice>> getThreeUsersChoices() async {
      // uidからそのユーザーのユーザーネームを取得する必要がある
      quizChoice1Profile =
          await friendsQuizViewModel.getQuizUserProfile(quizChoice1Uid);
      quizChoice2Profile =
          await friendsQuizViewModel.getQuizUserProfile(quizChoice2Uid);
      posterProfile = await friendsQuizViewModel.getQuizUserProfile(post.uid);

      // 3択のモデルを作成する
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
        quizChoiceUid: post.uid,
        quizChoiceUserName: posterProfile!.userName,
        quizChoiceUserImg: posterProfile!.userImg,
      );

      // 3択のリストを作る
      List<QuizChoice> quizChoices = [quizChoice1, quizChoice2, quizChoice3];

      // 3択をシャッフルする
      quizChoices.shuffle();

      return quizChoices;
    }

    List<Widget> threeChoiceWidget({required List<QuizChoice> choices}) {
      List<Widget> widgets = [];
      for (var choice in choices) {
        final quizListTile = ListTile(
          tileColor: AppColorTheme.color().gray3,
          leading: choice.quizChoiceUserImg != ''
              ? ExtendedImage.network(
                  choice.quizChoiceUserImg,
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
          title: Text(choice.quizChoiceUserName),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () async {
            // 選択したユーザーを元にダイアログを表示する
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  backgroundColor: Colors.deepPurple,
                  title: Center(
                    child: Text(
                      finalAnswerTitle,
                      style: GoogleFonts.oleoScript(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  children: [
                    SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          const Text(
                            answerPosterText,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                choice.quizChoiceUserImg != ''
                                    ? ExtendedImage.network(
                                        choice.quizChoiceUserImg,
                                        width: userImgLargeWidth,
                                        height: userImgLargeHeight,
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.circle,
                                      )
                                    : ExtendedImage.asset(
                                        'assets/images/user_gray_icon.png',
                                        width: userImgLargeWidth,
                                        height: userImgLargeHeight,
                                        shape: BoxShape.circle,
                                        fit: BoxFit.cover,
                                      ),
                                const SizedBox(height: 20),
                                Text(
                                  choice.quizChoiceUserName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  height: 48,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await answerOnPressed(
                                        profileViewModel: profileViewModel,
                                        friendsQuizViewModel:
                                            friendsQuizViewModel,
                                        localDatabaseViewModel:
                                            localDatabaseViewModel,
                                        posterProfile: posterProfile!,
                                        quizChoice: choice,
                                        quizChoice1Uid: quizChoice1Uid,
                                        quizChoice1Profile: quizChoice1Profile!,
                                        quizChoice2Profile: quizChoice2Profile!,
                                        quizChoice2Uid: quizChoice2Uid,
                                      );
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: const Text(decideToYouBtnText),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SimpleDialogOption(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    reconsiderBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
        widgets.add(quizListTile);
      }
      widgets.insert(1, const SizedBox(height: 6));
      widgets.insert(3, const SizedBox(height: 6));
      return widgets;
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
              children: [...threeChoiceWidget(choices: snapshot.data!)],
            ),
          );
        });
  }
}
