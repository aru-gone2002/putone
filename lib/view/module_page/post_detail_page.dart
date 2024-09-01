import 'package:flutter/material.dart';
import 'package:putone/local_database.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/model/post_like_model.dart';
import 'package:putone/view/item/audio_player_bar.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({super.key, required this.post});

  final LocalUserPost post;

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView>
    with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  final PostLikeModel _postLikeModel = PostLikeModel();
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    // 画面が開かれたら自動で再生し、画面が閉じられたら自動で停止するため
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
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

  Future<void> _initLikeStatus() async {
    final likeStatus = await _postLikeModel.getLikeStatus(widget.post.postId);
    setState(() {
      _isLiked = likeStatus;
    });
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
  Widget build(BuildContext contest) {
    return Scaffold(
        body: GestureDetector(
            onTap: _togglePlayPause,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(widget.post.postMusicImg),
                      SizedBox(height: 20),
                      Text(widget.post.postMusicName),
                      Text(widget.post.postMusicArtistName),
                      SizedBox(height: 20),
                      Text(widget.post.postMsg),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: AudioPlayerBar(
                      audioPlayer: _audioPlayer,
                    ),
                  ),
                )
              ],
            )));
  }
}
