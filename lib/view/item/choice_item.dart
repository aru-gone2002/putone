// lib/widgets/choice_item.dart

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class ChoiceItem extends StatelessWidget {
  final String uid;
  final String userName;
  final String userImg;
  final bool isSelected;

  const ChoiceItem({
    Key? key,
    required this.uid,
    required this.userName,
    required this.userImg,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 16,
            child: userImg.isNotEmpty
                ? ClipOval(
                    child: ExtendedImage.network(
                      userImg,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      cache: true,
                    ),
                  )
                : Text(userName[0], style: TextStyle(fontSize: 12)),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(userName)),
          if (isSelected) Icon(Icons.check, color: Colors.green),
        ],
      ),
    );
  }
}
