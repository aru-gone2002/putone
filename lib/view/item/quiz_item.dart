import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/three_users_choices.dart';
import 'package:putone/view_model/friends_quiz_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizItem extends ConsumerWidget {
  const QuizItem({
    super.key,
    required this.post,
  });

  final Post post;

  Future<void> openSpotify(Post post) async {
    final Uri spotifyUri = Uri.parse(post.postMusicSpotifyUrl);
    if (await canLaunchUrl(spotifyUri)) {
      await launchUrl(spotifyUri);
    } else {
      Fluttertoast.showToast(msg: failToOpenSpotifyLinkToastText);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FriendsQuizViewModel friendsQuizViewModel = FriendsQuizViewModel();
    friendsQuizViewModel.setRef(ref);

    final postAnswer = friendsQuizViewModel.postAnswers
        .where((element) => element.postId == post.postId)
        .toList();

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        margin: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: postAnswer.isEmpty
              ? Colors.white
              : postAnswer.first.answerUid == post.uid
                  ? AppColorTheme.color().correctColor
                  : AppColorTheme.color().wrongColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 4),
              color: Color.fromARGB(50, 0, 0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        width: 360,
        // TODO providerの情報を元に、回答済みかどうかを確かめる。
        // providerに入っているpostAnswerのpostIdと表示されているpostのpostIdを確認する
        child: postAnswer.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('正答率：15%'),
                  const SizedBox(height: 24),
                  ExtendedImage.network(
                    post.postMusicImg,
                    cache: true,
                    fit: BoxFit.cover,
                    width: friendsPostMusicImgWidth,
                    height: friendsPostMusicImgHegiht,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 240,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          post.postMusicArtistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          post.postMusicName,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (post.postMsg != '') const SizedBox(height: 16),
                        if (post.postMsg != '')
                          Text(
                            post.postMsg,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ThreeUsersChoices(post: post),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  //TODO 正解だったら
                  postAnswer.first.answerUid == post.uid
                      ? Text('正解！',
                          style: Theme.of(context).textTheme.labelSmall!)
                      : Text('不正解...',
                          style: Theme.of(context).textTheme.labelSmall!),

                  // Text('正解は？', style: Theme.of(context).textTheme.labelSmall!
                  //     // .copyWith(color: Colors.white),
                  //     ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      post.postMusicImg != ''
                          ? ExtendedImage.network(
                              postAnswer.first.posterUserImg,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              shape: BoxShape.circle,
                              cache: true,
                            )
                          : ExtendedImage.asset(
                              'assets/images/user_gray_icon.png',
                              width: 60,
                              height: 60,
                              shape: BoxShape.circle,
                              fit: BoxFit.cover,
                            ),
                      const SizedBox(width: 20),
                      Text(postAnswer.first.posterUserName,
                          style: Theme.of(context).textTheme.labelMedium
                          // !.copyWith(color: Colors.white),
                          ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExtendedImage.network(
                        post.postMusicImg,
                        width: 128,
                        height: 128,
                        cache: true,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.postMusicName,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium
                                // !.copyWith(color: Colors.white),
                                ),
                            const SizedBox(height: 8),
                            Text(
                              post.postMusicArtistName,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              //style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    post.postMsg,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    //style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 56),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 48,
                      minWidth: double.infinity,
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        LineIcons.spotify,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        // TODO Spotifyに飛ばす
                        await openSpotify(post);
                      },
                      label: const Text(
                        listenInSpotifyBtnText,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorTheme.color().gray2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
      ),
    );
  }
}
