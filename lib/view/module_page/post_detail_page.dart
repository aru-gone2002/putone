import 'package:flutter/material.dart';
import 'package:putone/local_database.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key, required this.post});

  final LocalUserPost post;

  @override
  Widget build(BuildContext contest) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Detail'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(post.postMusicImg),
            SizedBox(height: 20),
            Text(post.postMusicName),
            Text(post.postMusicArtistName),
            SizedBox(height: 20),
            Text(post.postMsg),
          ],
        )));
  }
}
