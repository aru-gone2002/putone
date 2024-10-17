import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/view/module_page/post_card.dart';
import 'package:putone/view_model/local_database_view_model.dart';

class MyQuizPage extends ConsumerWidget {
  const MyQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localDatabaseViewModel = LocalDatabaseViewModel()..setRef(ref);
    final postModel = PostModel();
    final uid = localDatabaseViewModel.getUidFromProvider();
    final userImg = localDatabaseViewModel.getUserImgFromProvider();
    final userName = localDatabaseViewModel.getUserNameFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('myquiz'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Post>>(
        stream: Stream.fromFuture(
            postModel.getPosterPostsByTime(uid?.toString() ?? '')),
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
              return PostCard(
                  post: post,
                  uid: uid!,
                  userImg: userImg!,
                  userName: userName!);
            },
          );
        },
      ),
    );
  }
}
