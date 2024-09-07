import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/providers/post_provider.dart';

import 'package:just_audio/just_audio.dart';
import 'package:putone/view/module_page/post_detail_page.dart';

class PostListView extends ConsumerStatefulWidget {
  final String initialPostId;
  final String uid;

  const PostListView({Key? key, required this.initialPostId, required this.uid})
      : super(key: key);

  @override
  ConsumerState<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends ConsumerState<PostListView> {
  late PageController _pageController;
  final PostModel _postModel = PostModel();
  AudioPlayer _audioPlayer = AudioPlayer(); // 共通のAudioPlayer
  int _currentIndex = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = await _postModel.getPosterPostsByTime(widget.uid);
    if (posts.isNotEmpty) {
      ref.read(postsProvider.notifier).state = posts;
      final initialIndex =
          posts.indexWhere((post) => post.postId == widget.initialPostId);
      final targetIndex = initialIndex != -1 ? initialIndex : 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(targetIndex);
        _playAudioForPost(targetIndex);
      });
      setState(() {
        _currentIndex = targetIndex;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _playAudioForPost(int index) async {
    final posts = ref.read(postsProvider);
    if (index < 0 || index >= posts.length) return; // 範囲外を防止
    final post = posts[index];

    try {
      await _audioPlayer.stop(); // 既存の再生を停止
      await _audioPlayer.setUrl(post.postMusicPreviewUrl); // 新しい音源を設定
      await _audioPlayer.setLoopMode(LoopMode.all); // ループ再生
      await _audioPlayer.play(); // 再生

      _currentIndex = index;
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose(); // 共通のプレイヤーを解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    // 投稿がロードされるまでローディング画面を表示
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        //     body: PageView.builder(
        //   scrollDirection: Axis.vertical,
        //   controller: _pageController,
        //   itemCount: posts.length,
        //   itemBuilder: (context, index) {
        //     final post = posts[index];
        //     return PostDetailView(
        //       post: post,
        //       audioPlayer: _audioPlayer, // 共通のAudioPlayerを渡す
        //       isCurrentPage: index == _currentIndex,
        //       onInit: () async {
        //         if (index != _currentIndex) {
        //           await _playAudioForPost(index); // ページ切り替え時に音楽を再生
        //         }
        //       },
        //     );
        //   },
        //   onPageChanged: (index) async {
        //     await _playAudioForPost(index);
        //   },
        // ));
        body: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0) {
          if (notification is ScrollUpdateNotification) {
            final PageMetrics metrics = notification.metrics as PageMetrics;
            final int currentPage = metrics.page!.round();
            if (currentPage != _currentIndex) {
              _playAudioForPost(currentPage);
            }
          }
        }
        return false;
      },
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostDetailView(
            post: post,
            audioPlayer: _audioPlayer,
            isCurrentPage: index == _currentIndex,
            onInit: () {}, // onInitは不要になります
          );
        },
      ),
    ));
  }
}
