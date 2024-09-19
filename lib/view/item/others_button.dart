import 'package:flutter/material.dart';

class OthersButton extends StatelessWidget {
  final int remainingAnswers;

  const OthersButton({Key? key, required this.remainingAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('その他 $remainingAnswers 件の回答を見る'),
      onPressed: () {
        // タップしたらすべての回答を見れる
      },
    );
  }
}
