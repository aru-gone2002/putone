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
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      print("pause");
    } else {
      _audioPlayer.play();
      print('play');
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

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
            ElevatedButton.icon(
              onPressed: _playPause,
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(_isPlaying ? 'Pause' : 'Play'),
            )
          ],
        )));
  }
}
