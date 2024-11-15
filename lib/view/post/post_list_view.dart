import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/view/module_page/post_detail_page.dart';
import 'package:putone/view_model/post_view_model.dart';

class PostListView extends ConsumerStatefulWidget {
  const PostListView({
    Key? key,
    required this.initialIndex,
    required this.posts,
  }) : super(key: key);

  final int initialIndex;
  final List<Post> posts;

  @override
  ConsumerState<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends ConsumerState<PostListView> {
  late PageController _pageController;
  final PostViewModel _postViewModel = PostViewModel();
  final AudioPlayer _audioPlayer = AudioPlayer(); // 共通のAudioPlayer
  late LockCachingAudioSource _audioSources;
  int _currentIndex = -1;
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _audioSources = LockCachingAudioSource(Uri.parse(''));
    _postViewModel.setRef(ref);
  }

  Future<void> _loadPosts() async {
    final posts = widget.posts;
    //ここでpost自体はあることは確認
    print('posts in post_list_view: $posts');

    if (posts.isNotEmpty) {
      // _postViewModel.saveTempPosts(posts);
      // final initialIndex =
      //     posts.indexWhere((post) => post.postId == widget.initialPostId);

      // final targetIndex = initialIndex != -1 ? initialIndex : 0;
      // print('initialIndex: $initialIndex');
      // print('targetIndex: $targetIndex');
      //TODOここでcontrollerにページを伝えているはず
      _pageController.jumpToPage(widget.initialIndex);
      await _playAudioForPost(widget.initialIndex);
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _pageController.jumpToPage(targetIndex);
      //   _playAudioForPost(targetIndex);
      // });
      // _isLoading = false;
      // return posts;
    }
    // return [];
  }

  Future<void> _playAudioForPost(int index) async {
    final posts = widget.posts;
    if (index < 0 || index >= posts.length) return; // 範囲外を防止
    final post = posts[index];
    if (post.postMusicPreviewUrl == '' || post.postMusicPreviewUrl.isEmpty) {
      await _audioPlayer.pause(); // 音源がない場合は再生を停止
      _currentIndex = index;
    } // 音源がない場合は再生しない
    try {
      // 既存の再生を停止
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      }
      _audioSources =
          LockCachingAudioSource(Uri.parse(post.postMusicPreviewUrl));
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
      body: FutureBuilder(
        future: _loadPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final posts = widget.posts;
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

          return const Center(
            child: Text("No posts available"),
          );
        },
      ),
    );
  }
}
