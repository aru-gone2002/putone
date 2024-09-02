import 'dart:ui';
import 'package:putone/model/post_user_model.dart';
import 'package:flutter/material.dart';
import 'package:putone/local_database.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/view/item/audio_player_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/item/like_button.dart';
import 'package:putone/view/item/spotigy_button.dart';

class PostDetailView extends ConsumerStatefulWidget {
  const PostDetailView({super.key, required this.post});

  final LocalUserPost post;

  @override
  ConsumerState<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView>
    with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Map<String, dynamic>? _userInfo;
  final PostUserModel _postUserModel = PostUserModel();

  @override
  void initState() {
    super.initState();
    // 画面が開かれたら自動で再生し、画面が閉じられたら自動で停止するため
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    _loadUserInfo();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(widget.post.postMusicPreciewUrl)));
      // widgetが開かれたら自動で再生する
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  Future<void> _loadUserInfo() async {
    final userInfo = await _postUserModel.getUserInfo(widget.post.uid);
    if (mounted) {
      setState(() {
        _userInfo = userInfo;
      });
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // アプリのライフサイクルの変化に応じた処理を追加
    if (state == AppLifecycleState.paused) {
      // アプリがバックグラウンドに移動したとき
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      _audioPlayer.play();
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
                  // audio player bar
                  AudioPlayerBar(
                    audioPlayer: _audioPlayer,
                  ),
                  // 投稿者情報
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: _userInfo != null
                              ? NetworkImage(_userInfo!['userImg'])
                              : null,
                          radius: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          _userInfo != null
                              ? _userInfo!['userName']
                              : 'Loading...',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(widget.post.postMusicImg),
                        SizedBox(height: 20),
                        Text(
                          widget.post.postMusicName,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.post.postMusicArtistName,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          widget.post.postMsg,
                          style: TextStyle(color: Colors.white),
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
                              spotifyUrl: widget.post.postMusicSpotifyUrl,
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
          // // オーディオプレイヤーバー
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: SafeArea(
          //     child: AudioPlayerBar(
          //       audioPlayer: _audioPlayer,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
