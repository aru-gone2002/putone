import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/theme/app_color_theme.dart';

class AudioPlayerBar extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioPlayerBar({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      // StreamBuilder<PlayerState>(
      //   stream: audioPlayer.playerStateStream,
      //   builder: (context, snapshot) {
      //     final playerState = snapshot.data;
      //     final processingState = playerState?.processingState;
      //     final playing = playerState?.playing;
      //     if (processingState == ProcessingState.loading ||
      //         processingState == ProcessingState.buffering) {
      //       return Container(
      //         margin: EdgeInsets.all(8.0),
      //         width: 32.0,
      //         height: 32.0,
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (playing != true) {
      //       return IconButton(
      //         icon: Icon(Icons.play_arrow),
      //         iconSize: 32.0,
      //         onPressed: audioPlayer.play,
      //       );
      //     } else if (processingState != ProcessingState.completed) {
      //       return IconButton(
      //         icon: Icon(Icons.pause),
      //         iconSize: 32.0,
      //         onPressed: audioPlayer.pause,
      //       );
      //     } else {
      //       return IconButton(
      //         icon: Icon(Icons.replay),
      //         iconSize: 32.0,
      //         onPressed: () => audioPlayer.seek(Duration.zero, index: 0),
      //       );
      //     }
      //   },
      // ),

      stream: audioPlayer.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data;
        final duration = audioPlayer.duration;
        if (position != null && duration != null) {
          return Column(
            children: [
              LinearProgressIndicator(
                value: position.inMilliseconds / duration.inMilliseconds,
                minHeight: 3,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColorTheme.color().mainColor),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
