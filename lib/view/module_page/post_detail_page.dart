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
  }) : super(key: key);

  final Post post;
  final AudioPlayer audioPlayer;

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
    // _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await widget.audioPlayer.setLoopMode(LoopMode.all);
      widget.audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        widget.audioPlayer.pause();
      } else {
        widget.audioPlayer.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // アプリのライフサイクルの変化に応じた処理を追加
    if (state == AppLifecycleState.paused) {
      // アプリがバックグラウンドに移動したとき
      widget.audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      widget.audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
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
          GestureDetector(
            onTap: _togglePlayPause,
            child: SafeArea(
              child: Column(
                children: [
                  // audio player bar (横いっぱいに広がる)
                  SizedBox(height: 8), // 上部に余白を追加
                  AudioPlayerBar(
                    audioPlayer: widget.audioPlayer,
                  ),
                  SizedBox(height: 8), // 下部に余白を追加
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // 投稿者情報
                          PostUserInfo(
                              uid: widget.post.uid,
                              postTimestamp: widget.post.postTimestamp),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 60),
                                Image.network(widget.post.postMusicImg),
                                SizedBox(height: 20),
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
                                // コメント（スクロール可能）
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      widget.post.postMsg,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LikeButton(
                                      postId: widget.post.postId,
                                      postOwnerId: widget.post.uid,
                                    ),
                                    SizedBox(width: 20),
                                    SpotifyButton(
                                      spotifyUrl:
                                          widget.post.postMusicSpotifyUrl,
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
