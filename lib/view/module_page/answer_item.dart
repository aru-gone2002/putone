import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/data/post_answer/post_answer.dart';

class AnswerItem extends StatelessWidget {
  final PostAnswer answer;
  final String correctUid;

  const AnswerItem({Key? key, required this.answer, required this.correctUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: answer.replyUserImg.isNotEmpty
            ? ClipOval(
                child: ExtendedImage.network(
                  answer.replyUserImg,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  cache: true,
                ),
              )
            : Text(answer.replyUserName[0]),
      ),
      title: Text(answer.replyUserName),
      subtitle: Text(answer.replyUserId),
      trailing: Icon(
        answer.answerUid == correctUid ? Icons.check_circle : Icons.cancel,
        color: answer.answerUid == answer.replyUid ? Colors.green : Colors.grey,
      ),
      onTap: () {
        // タップしたら詳細を見れる
      },
    );
  }
}
