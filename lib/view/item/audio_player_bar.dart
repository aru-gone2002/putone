import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putone/theme/app_color_theme.dart';

class AudioPlayerBar extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioPlayerBar({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: audioPlayer.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data;
        final duration = audioPlayer.duration;
        if (position != null && duration != null) {
          return Column(
            children: [
              SizedBox(height: 10), // Add some spacing here
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
