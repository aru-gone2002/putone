import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';

final spotifyAccessTokenProvider = StateProvider<String>((ref) => '');

final spotifySearchTracksProvider =
    StateProvider<List<SpotifyTrack>>((ref) => []);
