import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotifyButton extends StatelessWidget {
  final String spotifyUrl;
  const SpotifyButton({Key? key, required this.spotifyUrl}) : super(key: key);

  void _openSpotify(BuildContext context) async {
    final Uri spotifyUri = Uri.parse(spotifyUrl);
    if (await canLaunchUrl(spotifyUri)) {
      await launchUrl(spotifyUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open Spotify link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(LineIcons.spotify),
      color: AppColorTheme.color().gray3,
      iconSize: 40,
      onPressed: () => _openSpotify(context),
    );
  }
}
