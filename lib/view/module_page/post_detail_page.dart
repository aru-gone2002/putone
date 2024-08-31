import 'package:flutter/material.dart';
import 'package:putone/local_database.dart';
import 'package:just_audio/just_audio.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({super.key, required this.post});

  final LocalUserPost post;

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(widget.post.postMusicPreciewUrl)));
      // widgetが開かれたら自動で再生する
      _audioPlayer.play();
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  // void _playPause() {
  //   if (_isPlaying) {
  //     _audioPlayer.pause();
  //     print("pause");
  //   } else {
  //     _audioPlayer.play();
  //     print('play');
  //   }
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //   });
  // }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contest) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Detail'),
        ),
        body: Center(
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
            StreamBuilder<PlayerState>(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    width: 64.0,
                    height: 64.0,
                    child: CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: Icon(Icons.play_arrow),
                    iconSize: 64.0,
                    onPressed: _audioPlayer.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: Icon(Icons.pause),
                    iconSize: 64.0,
                    onPressed: _audioPlayer.pause,
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.replay),
                    iconSize: 64.0,
                    onPressed: () => _audioPlayer.seek(Duration.zero, index: 0),
                  );
                }
              },
            ),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data;
                final duration = _audioPlayer.duration;
                if (position != null && duration != null) {
                  return LinearProgressIndicator(
                    value: position.inMilliseconds / duration.inMilliseconds,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            // ElevatedButton.icon(
            //   onPressed: _playPause,
            //   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            //   label: Text(_isPlaying ? 'Pause' : 'Play'),
            // )
          ],
        )));
  }
}
