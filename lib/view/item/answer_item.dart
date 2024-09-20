// lib/widgets/answer_item.dart

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/view/item/choice_item.dart';

class AnswerItem extends StatefulWidget {
  final PostAnswer answer;
  final String correctUid;
  final String correctUserName;
  final String correctUserImg;

  const AnswerItem(
      {Key? key,
      required this.answer,
      required this.correctUid,
      required this.correctUserName,
      required this.correctUserImg})
      : super(key: key);

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: widget.answer.replyUserImg.isNotEmpty
                ? ClipOval(
                    child: ExtendedImage.network(
                      widget.answer.replyUserImg,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      cache: true,
                    ),
                  )
                : Text(widget.answer.replyUserName[0]),
          ),
          title: Text(widget.answer.replyUserName),
          subtitle: Text(widget.answer.replyUserId),
          trailing: Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Icon(
              widget.answer.answerUid == widget.correctUid
                  ? Icons.radio_button_unchecked
                  : Icons.close,
              color: widget.answer.answerUid == widget.correctUid
                  ? Colors.green
                  : Colors.grey,
              size: 24,
            ),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChoiceItem(
                  uid: widget.answer.quizChoice1Uid,
                  userName: widget.answer.quizChoice1UserName,
                  userImg: widget.answer.quizChoice1UserImg,
                  isSelected:
                      widget.answer.answerUid == widget.answer.quizChoice1Uid,
                ),
                ChoiceItem(
                  uid: widget.answer.quizChoice2Uid,
                  userName: widget.answer.quizChoice2UserName,
                  userImg: widget.answer.quizChoice2UserImg,
                  isSelected:
                      widget.answer.answerUid == widget.answer.quizChoice2Uid,
                ),
                ChoiceItem(
                  uid: widget.correctUid,
                  userName: widget.correctUserName,
                  userImg: widget.answer.replyUserImg,
                  isSelected:
                      widget.answer.answerUid == widget.answer.posterUid,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
