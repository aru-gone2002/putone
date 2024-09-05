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
  final Map<String, Post> _postMap = {};
  final Map<int, AudioPlayer> _audioPlayers = {};
  AudioPlayer? _currentPlayer;
  int _currentIndex = -1;

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
        _initAudioPlayer(targetIndex, posts[targetIndex].postMusicPreviewUrl);
      });
    }
  }

  Future<void> _initAudioPlayer(int index, String url) async {
    // 現在のプレイヤーを停止して新しいプレイヤーを初期化
    await _currentPlayer?.pause();
    await _currentPlayer?.dispose();

    if (!_audioPlayers.containsKey(index)) {
      _currentPlayer = AudioPlayer();
      await _currentPlayer!.setUrl(url);
      await _currentPlayer!.setLoopMode(LoopMode.all);
      _audioPlayers[index] = _currentPlayer!;
    }
    _currentPlayer = _audioPlayers[index];
    await _currentPlayer!.play();
    _currentIndex = index;
    // _currentIndex = index;
    // _audioPlayers[index]?.play();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    // for (var player in _audioPlayers.values) {
    //   player.dispose();
    // }
    // super.dispose();
    _pageController.dispose();
    // _currentPlayer?.dispose();
    for (var player in _audioPlayers.values) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
        body: PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        if (_currentPlayer == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return PostDetailView(
          post: post,
          audioPlayer: _audioPlayers[index] ?? AudioPlayer(),
          isCurrentPage: index == _currentIndex,
          onInit: () async {
            if (index != _currentIndex) {
              await _initAudioPlayer(index, post.postMusicPreviewUrl);
            }
          },
        );
      },
      onPageChanged: (index) async {
        ref.read(postProvider.notifier).state = posts[index];
        await _audioPlayers[_currentIndex]?.pause();
        await _initAudioPlayer(index, posts[index].postMusicPreviewUrl);
      },
    ));
  }
}
