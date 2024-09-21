import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // final FollowViewModel followViewModel = FollowViewModel();
  // final ProfileViewModel profileViewModel = ProfileViewModel();
  // final FriendsQuizViewModel friendsQuizViewModel = FriendsQuizViewModel();
  // final LocalDatabaseViewModel localDatabaseViewModel =
  //     LocalDatabaseViewModel();
  // UserProfile? quizChoice1Profile;
  // UserProfile? quizChoice2Profile;
  // UserProfile? posterProfile;
  // late String quizChoice1Uid;
  // late String quizChoice2Uid;

  // void initialFunction() {
  //   //TODO ここでfollowingUsersは取得できていない
  //   final followingUsers = followViewModel.followingUsers;
  //   //やりたい処理としては、followingUsersから自分と投稿主以外のフォローユーザーを取得する
  //   // print('followingUsers: $followingUsers');

  //   final exceptMeAndPosterFollowingUsers = followingUsers
  //       .where(
  //         (followingUser) =>
  //             //自分じゃないことを検証
  //             //投稿主じゃないことを検証
  //             followingUser.followingUid != profileViewModel.uid &&
  //             followingUser.followingUid != post.uid,
  //       )
  //       .toList();
  //   // print('exceptMeAndPosterFollowingUsers: $exceptMeAndPosterFollowingUsers');

  //   //TODO 自分と投稿主以外のフォローユーザーから任意で2人を取得する
  //   Random random = Random();
  //   int index1 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
  //   int index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);

  //   // 重複を避けるために、異なるインデックスになるまで再生成
  //   while (index1 == index2) {
  //     index2 = random.nextInt(exceptMeAndPosterFollowingUsers.length);
  //   }

  //   quizChoice1Uid = exceptMeAndPosterFollowingUsers[index1].followingUid;
  //   quizChoice2Uid = exceptMeAndPosterFollowingUsers[index2].followingUid;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   followViewModel.setRef(ref);
  //   profileViewModel.setRef(ref);
  //   friendsQuizViewModel.setRef(ref);
  //   localDatabaseViewModel.setRef(ref);
  //   initialFunction();
  // }

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
    //TODO ここでfollowingUsersは取得できていない
    final followingUsers = followViewModel.followingUsers;
    //やりたい処理としては、followingUsersから自分と投稿主以外のフォローユーザーを取得する
    // print('followingUsers: $followingUsers');

    final exceptMeAndPosterFollowingUsers = followingUsers
        .where(
          (followingUser) =>
              //自分じゃないことを検証
              //投稿主じゃないことを検証
              followingUser.followingUid != profileViewModel.uid &&
              followingUser.followingUid != post.uid,
        )
        .toList();
    // print('exceptMeAndPosterFollowingUsers: $exceptMeAndPosterFollowingUsers');

    //TODO 自分と投稿主以外のフォローユーザーから任意で2人を取得する
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
                  onTap: () async {
                    // TODO
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
                      answerUid: snapshot.data![0].quizChoiceUid,
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

                    // TODO ローカルDBに格納する
                    await localDatabaseViewModel.appDatabase!
                        .insertLocalUserPostAnswer(postAnswer);

                    friendsQuizViewModel.addPostAnswers(postAnswer);
                    // final localPostAnswers = await localDatabaseViewModel
                    //     .appDatabase!
                    //     .getAllLocalUserPostAnswers();
                    // print('localPostAnswers: $localPostAnswers');

                    // 回答結果のuidが投稿主のuidと一致するかを検証する
                    // isAnswerCorrect =
                    //     post.uid == snapshot.data![0].quizChoiceUid;
                  },
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
                  onTap: () async {
                    // TODO
                    // 選択したユーザーを取得する
                    // providerにpostAnswerを格納
                    // FirestoreにpostAnswersを追加する
                    final postAnswer = PostAnswer(
                      postId: post.postId,
                      posterUid: post.uid,
                      posterUserName: posterProfile!.userName,
                      posterUserImg: posterProfile!.userImg,
                      replyUid: profileViewModel.uid,
                      replyUserId: profileViewModel.userId,
                      replyUserName: profileViewModel.userName,
                      replyUserImg: profileViewModel.userImg,
                      answerUid: snapshot.data![1].quizChoiceUid,
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

                    // TODO ローカルDBに格納する
                    await localDatabaseViewModel.appDatabase!
                        .insertLocalUserPostAnswer(postAnswer);

                    // final localPostAnswers = await localDatabaseViewModel
                    //     .appDatabase!
                    //     .getAllLocalUserPostAnswers();
                    // print('localPostAnswers: $localPostAnswers');

                    friendsQuizViewModel.addPostAnswers(postAnswer);

                    // 回答結果のuidが投稿主のuidと一致するかを検証する
                    // isAnswerCorrect =
                    //     post.uid == snapshot.data![1].quizChoiceUid;
                  },
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
                  onTap: () async {
                    // TODO
                    // 選択したユーザーを取得する
                    // FirestoreにpostAnswersを追加する

                    final postAnswer = PostAnswer(
                      postId: post.postId,
                      posterUid: post.uid,
                      posterUserName: posterProfile!.userName,
                      posterUserImg: posterProfile!.userImg,
                      replyUid: profileViewModel.uid,
                      replyUserId: profileViewModel.userId,
                      replyUserName: profileViewModel.userName,
                      replyUserImg: profileViewModel.userImg,
                      answerUid: snapshot.data![2].quizChoiceUid,
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

                    //TODO ここでエラーが出てる
                    // TODO ローカルDBに格納する
                    await localDatabaseViewModel.appDatabase!
                        .insertLocalUserPostAnswer(postAnswer);

                    // print('insertLocalUserPostAnswers');

                    // final localPostAnswers = await localDatabaseViewModel
                    //     .appDatabase!
                    //     .getAllLocalUserPostAnswers();
                    // print('localPostAnswers: $localPostAnswers');

                    friendsQuizViewModel.addPostAnswers(postAnswer);

                    // 回答結果のuidが投稿主のuidと一致するかを検証する
                    // isAnswerCorrect =
                    //     post.uid == snapshot.data![2].quizChoiceUid;
                  },
                ),
              ],
            ),
          );
        });
  }
}
