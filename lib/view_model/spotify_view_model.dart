import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/model/spotify_model.dart';
import 'package:putone/providers/spotify_access_provider.dart';

class SpotifyViewModel {
  final SpotifyModel _spotifyModel = SpotifyModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  String get spotifyAccessToken => _ref.watch(spotifyAccessTokenProvider);

  List<SpotifyTrack> get spotifySearchTracks =>
      _ref.watch(spotifySearchTracksProvider);

  void saveSpotifyAccessToken(String value) {
    _ref.read(spotifyAccessTokenProvider.notifier).state = value;
  }

  void saveSpotifySearchTracks(List<SpotifyTrack> value) {
    _ref.read(spotifySearchTracksProvider.notifier).state = value;
  }

  Future<void> fetchSpotifyAccessToken() async {
    final accessToken = await _spotifyModel.fetchAccessToken();
    if (accessToken != null) {
      saveSpotifyAccessToken(accessToken);
    }
  }

  Future<void> searchTracks({
    required String searchTrackName,
    required String searchArtistName,
  }) async {
    final List<SpotifyTrack> spotifyTracks = await _spotifyModel.searchTracks(
      accessToken: spotifyAccessToken,
      searchTrackName: searchTrackName,
      seachArtistName: searchArtistName,
    );
    saveSpotifySearchTracks(spotifyTracks);
    // }
  }
}