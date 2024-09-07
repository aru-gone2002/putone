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
        final position = snapshot.data ?? Duration.zero;
        final duration = audioPlayer.duration ?? Duration.zero;

        // ゼロ除算を防ぐ
        final progress = duration.inMilliseconds > 0
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0;

        // progressが0.0から1.0の範囲内にあることを確認
        final clampedProgress = progress.clamp(0.0, 1.0);
        if (clampedProgress != null) {
          return Column(
            children: [
              SizedBox(height: 10), // Add some spacing here
              LinearProgressIndicator(
                value: clampedProgress,
                minHeight: 3,
                backgroundColor: AppColorTheme.color().gray3,
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
