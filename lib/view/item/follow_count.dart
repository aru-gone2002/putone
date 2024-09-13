import 'package:flutter/material.dart';

class FollowCount extends StatelessWidget {
  const FollowCount({
    super.key,
    required this.count,
    required this.label,
    required this.onTap,
  });

  final String count;
  final String label;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        child: Column(
          children: [
            Text(
              count,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
