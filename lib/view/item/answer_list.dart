import 'package:flutter/material.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'answer_item.dart';
import 'others_button.dart';

class AnswersList extends StatelessWidget {
  final List<PostAnswer> answers;
  final String correctUid;

  const AnswersList({Key? key, required this.answers, required this.correctUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...answers.take(3).map(
            (answer) => AnswerItem(answer: answer, correctUid: correctUid)),
        if (answers.length > 3)
          OthersButton(remainingAnswers: answers.length - 3),
      ],
    );
  }
}
