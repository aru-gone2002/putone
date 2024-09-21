import 'package:flutter/material.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'answer_item.dart';

class AnswersList extends StatefulWidget {
  final List<PostAnswer> answers;
  final String correctUid;
  final String correctUserImg;
  final String correctUserName;
  final bool showPercentage;

  const AnswersList({
    Key? key,
    required this.answers,
    required this.correctUid,
    required this.correctUserImg,
    required this.correctUserName,
    this.showPercentage = true,
  }) : super(key: key);
  @override
  _AnswersListState createState() => _AnswersListState();
}

class _AnswersListState extends State<AnswersList> {
  bool isShowAll = false;
  @override
  Widget build(BuildContext context) {
    List<PostAnswer> displayedAnswers =
        isShowAll ? widget.answers : widget.answers.take(3).toList();
    return Column(
      children: [
        ...displayedAnswers.map((answer) => AnswerItem(
            answer: answer,
            correctUid: widget.correctUid,
            correctUserImg: widget.correctUserImg,
            correctUserName: widget.correctUserName)),
        if (widget.answers.length > 3)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorTheme.color().gray1,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size(120, 36),
            ),
            child: Text(
              isShowAll ? 'close' : 'others (${widget.answers.length - 3})',
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              setState(() {
                isShowAll = !isShowAll;
              });
            },
          )
      ],
    );
  }
}
