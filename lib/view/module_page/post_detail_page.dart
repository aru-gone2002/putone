import 'package:flutter/material.dart';
import 'package:putone/data/post_like/post_like.dart';
import 'package:putone/local_database.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/model/post_like_model.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/view/item/audio_player_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final PostLikeModel _postLikeModel = PostLikeModel();
  late Stream<bool> _isLikedStream;
  late Stream<int> _likeCountStream;

  @override
  void initState() {
    super.initState();
    // 画面が開かれたら自動で再生し、画面が閉じられたら自動で停止するため
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    // フレームの描画後に_initLikeStreamsを呼び出す
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _initLikeStreams();
    // });
    _initLikeStreams();
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

  // initState内ではrefを直接使用できないため、
  // WidgetsBinding.instance.addPostFrameCallback を使用して、
  // 最初のフレームが描画された後に ref にアクセスする
  void _initLikeStreams() {
    final userProfile = ref.read(userProfileProvider);
    _isLikedStream = _postLikeModel.hasUserLiked(
        widget.post.postId, widget.post.uid, userProfile.uid);
    _likeCountStream =
        _postLikeModel.getPostLikeCount(widget.post.postId, widget.post.uid);
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

  Future<void> _toggleLike() async {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile.uid.isNotEmpty) {
      await _postLikeModel.updateLike(
        widget.post.postId,
        widget.post.uid,
        userProfile.uid,
        userProfile.userImg,
        userProfile.userName,
      );
      _initLikeStreams(); // いいねの状態を再取得
    }
  }

  void _showLikesList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<PostLike>>(
          stream: _postLikeModel.getPostLikeList(
              widget.post.postId, widget.post.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No likes yet'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final like = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(like.userImg),
                  ),
                  title: Text('liked user: ${like.userName}'),
                );
              },
            );
          },
        );
      },
    );
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
                      StreamBuilder<bool>(
                        stream: _isLikedStream,
                        builder: (context, isLikedSnapshot) {
                          return StreamBuilder<int>(
                            stream: _likeCountStream,
                            builder: (context, likeCountSnapshot) {
                              final isLiked = isLikedSnapshot.data ?? false;
                              final likeCount = likeCountSnapshot.data ?? 0;
                              return GestureDetector(
                                onTap: _toggleLike,
                                onLongPress: _showLikesList,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked ? Colors.red : null,
                                    ),
                                    SizedBox(width: 8),
                                    Text('$likeCount likes'),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
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
