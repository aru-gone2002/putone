import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/model/post_answer_model.dart';
import 'package:putone/view/item/answer_list.dart';
import 'package:putone/view/item/answer_pie_chart.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  final String uid;

  const PostCard({Key? key, required this.post, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAnswerModel = PostAnswerModel();

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ExtendedImage.network(
                    post.postMusicImg,
                    cache: true,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.postMusicName,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 4),
                      Text(post.postMusicArtistName,
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            StreamBuilder<List<PostAnswer>>(
                stream: postAnswerModel.getPostAnswersStream(uid, post.postId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('回答の取得に失敗しました: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('まだ回答がありません');
                  }

                  final answers = snapshot.data!;
                  return Column(
                    children: [
                      StreamBuilder<double>(
                        stream: postAnswerModel
                            .calculateCorrectAnswerPercentageStream(
                                uid, post.postId),
                        builder: (context, percentageSnapshot) {
                          if (percentageSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (percentageSnapshot.hasError) {
                            return Text('正答率の取得に失敗しました');
                          }

                          final percentage = percentageSnapshot.data ?? 0.0;
                          return AnswerPieChart(percentage: percentage);
                        },
                      ),
                      SizedBox(height: 16),
                      AnswersList(answers: answers, correctUid: uid),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
