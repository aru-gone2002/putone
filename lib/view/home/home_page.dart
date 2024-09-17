import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view_model/post_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PostViewModel _postViewModel = PostViewModel();

  @override
  void initState() {
    super.initState();
    _postViewModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          homePageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => toUserSearchPage(context: context),
            icon: const Icon(
              Icons.person_search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async =>
                await _postViewModel.getFollowingUsersPosts(),
            child: const Text('フォローユーザーの投稿取得')),
      ),
    );
  }
}
