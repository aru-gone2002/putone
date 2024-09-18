import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/three_users_choices.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        margin: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Column(
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
        ),
      ),
    );
  }
}
