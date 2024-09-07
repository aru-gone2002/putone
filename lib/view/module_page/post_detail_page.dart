import 'dart:ui';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_user_model.dart';
import 'package:flutter/material.dart';
import 'package:putone/local_database.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/view/item/audio_player_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/item/like_button.dart';
import 'package:putone/view/item/post_user_info.dart';
import 'package:putone/view/item/spotigy_button.dart';
import 'package:putone/theme/app_color_theme.dart';

class PostDetailView extends ConsumerStatefulWidget {
  const PostDetailView({
    Key? key,
    required this.post,
    required this.audioPlayer,
    required this.isCurrentPage,
    required this.onInit,
  }) : super(key: key);

  final Post post;
  final AudioPlayer audioPlayer;
  final bool isCurrentPage;
  final VoidCallback onInit;

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
    widget.onInit();
  }

  @override
  void didUpdateWidget(PostDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrentPage != oldWidget.isCurrentPage) {
      _updatePlayingState();
    }
  }

  void _updatePlayingState() {
    if (widget.isCurrentPage) {
      _playAudio();
    } else {
      _pauseAudio();
    }
  }

  void _playAudio() {
    widget.audioPlayer?.play();
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseAudio() {
    widget.audioPlayer?.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _togglePlayPause() {
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
    if (state == AppLifecycleState.paused) {
      _pauseAudio();
    } else if (state == AppLifecycleState.resumed && widget.isCurrentPage) {
      _playAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.network(
            widget.post.postMusicImg,
            fit: BoxFit.cover,
          ),
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
                  child: AudioPlayerBar(audioPlayer: widget.audioPlayer),
                ),
                // メインコンテンツ
                Expanded(
                  child: GestureDetector(
                    onTap: _togglePlayPause,
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
                                      child: Image.network(
                                          widget.post.postMusicImg),
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                  SizedBox(height: 20),
                                  // コメント
                                  Flexible(
                                    flex: 2,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.post.postMsg,
                                        style: TextStyle(color: Colors.white),
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
                                SizedBox(width: 20),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
