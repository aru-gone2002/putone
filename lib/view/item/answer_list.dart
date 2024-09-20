import 'package:flutter/material.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'answer_item.dart';
import 'others_button.dart';

class AnswersList extends StatelessWidget {
  final List<PostAnswer> answers;
  final String correctUid;
  final String correctUserImg;
  final String correctUserName;

  const AnswersList(
      {Key? key,
      required this.answers,
      required this.correctUid,
      required this.correctUserImg,
      required this.correctUserName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...answers.take(3).map((answer) => AnswerItem(
            answer: answer,
            correctUid: correctUid,
            correctUserImg: correctUserImg,
            correctUserName: correctUserName)),
        if (answers.length > 3)
          OthersButton(remainingAnswers: answers.length - 3),
      ],
    );
  }
}
