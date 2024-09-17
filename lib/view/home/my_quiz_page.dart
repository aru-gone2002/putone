import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';

import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/providers/post_answer_provider.dart';
import 'package:putone/providers/user_auth_provider.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/spotify_view_model.dart';
import 'package:fl_chart/fl_chart.dart';

class MyQuizPage extends ConsumerWidget {
  const MyQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localDatabaseViewModel = LocalDatabaseViewModel()..setRef(ref);
    final postModel = PostModel();
    final uid = localDatabaseViewModel.getUidFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('myquiz'),
      ),
      body: FutureBuilder<List<Post>>(
        future: postModel.getPosterPostsByTime(uid?.toString() ?? ''),
        builder: (context, snapshot) {
          // デバッグ情報を追加
          print("currentUser.uid: ${uid}");
          print('Connection state: ${snapshot.connectionState}');
          print('Has error: ${snapshot.hasError}');
          print('Error: ${snapshot.error}');
          print('Has data: ${snapshot.hasData}');
          print('Data length: ${snapshot.data?.length}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('投稿がありません'));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answersAsyncValue = ref
        .watch(postAnswersProvider({'uid': post.uid, 'postId': post.postId}));
    print('answersAsyncValue: $answersAsyncValue');
    print('answersAsyncValue: ${answersAsyncValue.asData?.value}');
    final percentageAsyncValue = ref.watch(correctAnswerPercentageProvider(
        {'uid': post.uid, 'postId': post.postId}));

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.postMusicName,
                style: Theme.of(context).textTheme.titleLarge),
            Text(post.postMusicArtistName,
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 16),
            Text('投稿日時: ${post.postTimestamp.toString()}'),
            answersAsyncValue.when(
              data: (answers) {
                if (answers.isEmpty) {
                  return Text('まだ回答がありません');
                }
                return percentageAsyncValue.when(
                  data: (percentage) => AnswerPieChart(percentage: percentage),
                  loading: () => CircularProgressIndicator(),
                  error: (error, __) => Text('正答率の取得に失敗しました'),
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error, __) {
                if (error.toString().contains('permission-denied')) {
                  return Text('回答の取得に失敗しました: 権限がありません');
                }
                return Text('回答の取得に失敗しました');
              },
            ),
            SizedBox(height: 16),
            answersAsyncValue.when(
              data: (answers) {
                if (answers.isEmpty) {
                  return SizedBox.shrink(); // 回答がない場合は何も表示しない
                }
                return AnswersList(answers: answers);
              },
              loading: () => CircularProgressIndicator(),
              error: (_, __) =>
                  SizedBox.shrink(), // エラー時は何も表示しない（上のエラーメッセージで十分）
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerPieChart extends StatelessWidget {
  final double percentage;

  const AnswerPieChart({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.green,
              value: percentage,
              title: '${percentage.toStringAsFixed(1)}%',
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 100 - percentage,
              title: '${(100 - percentage).toStringAsFixed(1)}%',
              radius: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class AnswersList extends StatelessWidget {
  final List<PostAnswer> answers;

  const AnswersList({Key? key, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...answers.take(3).map((answer) => AnswerItem(answer: answer)),
        if (answers.length > 3)
          OthersButton(remainingAnswers: answers.length - 3),
      ],
    );
  }
}

class AnswerItem extends StatelessWidget {
  final PostAnswer answer;

  const AnswerItem({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the expanding/collapsing functionality for each answer
    return ListTile(
      title: Text(answer.replyUserId),
      trailing:
          Icon(answer.answerUid == answer.replyUid ? Icons.check : Icons.close),
      onTap: () {
        // Implement tapping functionality to show detailed answers
      },
    );
  }
}

class OthersButton extends StatelessWidget {
  final int remainingAnswers;

  const OthersButton({Key? key, required this.remainingAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('その他 $remainingAnswers 件の回答を見る'),
      onPressed: () {
        // Implement functionality to show all answers
      },
    );
  }
}
