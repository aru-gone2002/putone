import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:putone/data/post/post.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/view/item/audio_player_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/item/like_button.dart';
import 'package:putone/view/item/post_user_info.dart';
import 'package:putone/view/item/spotify_button.dart';
import 'package:putone/theme/app_color_theme.dart';

class PostDetailView extends ConsumerStatefulWidget {
  const PostDetailView({
    Key? key,
    required this.post,
    required this.audioPlayer,
    required this.isCurrentPage,
  }) : super(key: key);

  final Post post;
  final AudioPlayer audioPlayer;
  final bool isCurrentPage;

  @override
  ConsumerState<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView>
    with WidgetsBindingObserver {
  // late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // 画面が開かれたら自動で再生し、画面が閉じられたら自動で停止するため
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didUpdateWidget(PostDetailView oldWidget) async {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrentPage != oldWidget.isCurrentPage) {
      await _updatePlayingState();
    }
  }

  Future<void> _updatePlayingState() async {
    if (widget.isCurrentPage) {
      _playAudio();
    } else {
      _pauseAudio();
    }
  }

  void _playAudio() async {
    await widget.audioPlayer?.play();
    _isPlaying = true;
  }

  void _pauseAudio() async {
    await widget.audioPlayer?.pause();
    _isPlaying = false;
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      _pauseAudio();
    } else {
      _playAudio();
    }
  }

  @override
  void dispose() {
    // widget.audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_isPlaying) {
        _playAudio(); // プレイヤーが停止している場合のみ再生再開
      }
    } else if (state == AppLifecycleState.paused) {
      _pauseAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 背景画像
            ExtendedImage.network(widget.post.postMusicImg,
                fit: BoxFit.cover, cache: true),
            // ぼかしエフェクト
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            // メインコンテンツ
            SafeArea(
              child: Column(
                children: [
                  // AudioPlayerBar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: widget.post.postMusicPreviewUrl.isNotEmpty
                        ? AudioPlayerBar(audioPlayer: widget.audioPlayer)
                        : const Text("No preview available",
                            style: TextStyle(color: Colors.white)),
                  ),
                  // メインコンテンツ
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // 投稿者情報
                          PostUserInfo(
                            uid: widget.post.uid,
                            postTimestamp: widget.post.postTimestamp,
                          ),
                          // 中央のコンテンツ
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 音楽アートワーク
                                  Flexible(
                                    flex: 3,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: ExtendedImage.network(
                                          widget.post.postMusicImg,
                                          cache: true),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // アーティスト名
                                  Text(
                                    widget.post.postMusicArtistName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: AppColorTheme.color().gray3,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // 曲名
                                  Text(
                                    widget.post.postMusicName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: AppColorTheme.color().gray3,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  // コメント
                                  Flexible(
                                    flex: 2,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.post.postMsg,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 下部のボタン
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LikeButton(
                                  postId: widget.post.postId,
                                  postOwnerId: widget.post.uid,
                                ),
                                const SizedBox(width: 20),
                                SpotifyButton(
                                  spotifyUrl: widget.post.postMusicSpotifyUrl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
