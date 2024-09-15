import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/providers/post_provider.dart';
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
  late LockCachingAudioSource _audioSources;
  int _currentIndex = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _audioSources = LockCachingAudioSource(Uri.parse(''));
  }

  Future<List<Post>> _loadPosts() async {
    final posts = await _postModel.getPosterPostsByTime(widget.uid);
    if (posts.isNotEmpty) {
      ref.read(TempPostsProvider.notifier).state = posts;
      final initialIndex =
          posts.indexWhere((post) => post.postId == widget.initialPostId);

      final targetIndex = initialIndex != -1 ? initialIndex : 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(targetIndex);
        _playAudioForPost(targetIndex);
      });
      _isLoading = false;
      return posts;
    }
    return [];
  }

  Future<void> _playAudioForPost(int index) async {
    final posts = ref.read(TempPostsProvider);
    if (index < 0 || index >= posts.length) return; // 範囲外を防止
    final post = posts[index];
    if (post.postMusicPreviewUrl == '' || post.postMusicPreviewUrl.isEmpty) {
      await _audioPlayer.pause(); // 音源がない場合は再生を停止
      _currentIndex = index;
    }
    ; // 音源がない場合は再生しない
    try {
      // 既存の再生を停止
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      }
      _audioSources =
          await LockCachingAudioSource(Uri.parse(post.postMusicPreviewUrl));
      await _audioPlayer.setAudioSource(_audioSources);
      await _audioPlayer.setLoopMode(LoopMode.all); // ループ再生
      await _audioPlayer.play(); // 再生
      _currentIndex = index;
    } catch (e) {
      print("Error playing audio: $e");
      if (e is PlayerException) {
        if (e.code == 'abort') {}
      }
    }
  }

  @override
  void dispose() async {
    // ページが破棄される際に、オーディオキャッシュを解放
    _audioSources.clearCache();
    _pageController.dispose();
    _audioPlayer.dispose(); // 共通のプレイヤーを解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: _loadPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final posts = snapshot.data!;
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0) {
                  if (notification is ScrollUpdateNotification) {
                    final PageMetrics metrics =
                        notification.metrics as PageMetrics;
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
                  );
                },
              ),
            );
          }

          return Center(
            child: Text("No posts available"),
          );
        },
      ),
    );
  }
}
