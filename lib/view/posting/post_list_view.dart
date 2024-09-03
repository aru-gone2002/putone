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
  final Map<String, AudioPlayer> _audioPlayers = {};
  AudioPlayer? _currentPlayer;

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
      if (initialIndex != -1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pageController.jumpToPage(initialIndex);
        });
      } else {
        // 指定された投稿が見つからない場合は最新の投稿（リストの先頭）を表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pageController.jumpToPage(0);
        });
      }
    }
  }

  Future<AudioPlayer> _getAudioPlayer(String postId, String url) async {
    if (!_audioPlayers.containsKey(postId)) {
      final player = AudioPlayer();
      await player.setUrl(url);
      await player.setLoopMode(LoopMode.all);
      _audioPlayers[postId] = player;
    }
    return _audioPlayers[postId]!;
  }

  void _cleanupAudioPlayers(int currentIndex) {
    _audioPlayers.forEach((postId, player) {
      if (player != _currentPlayer) {
        player.stop();
        player.dispose();
      }
    });
    _audioPlayers.removeWhere((postId, player) => player != _currentPlayer);
  }

  // いらないかも？
  void _disposeAudioPlayer(String postId) {
    final player = _audioPlayers.remove(postId);
    player?.dispose();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
        return FutureBuilder<AudioPlayer>(
          future: _getAudioPlayer(post.postId, post.postMusicPreviewUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return PostDetailView(
                post: post,
                audioPlayer: snapshot.data!,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
      onPageChanged: (index) async {
        ref.read(postProvider.notifier).state = posts[index];

        // Stop current player if exists
        await _currentPlayer?.stop();

        // Get new player and start playing
        _currentPlayer = await _getAudioPlayer(
            posts[index].postId, posts[index].postMusicPreviewUrl);
        _currentPlayer?.play();

        // Clean up unused audio players
        _cleanupAudioPlayers(index);
      },
    ));
  }
}
