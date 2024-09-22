import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/local_database.dart';
import 'package:putone/model/artist_follow_model.dart';
import 'package:putone/providers/artist_provider.dart';

class ArtistFollowViewModel {
  final ArtistFollowModel _artistFollowModel = ArtistFollowModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<Artist> get favoriteArtists => _ref.read(favoriteArtistsProvider);

  void saveFavoriteArtists(List<Artist> value) {
    _ref.read(favoriteArtistsProvider.notifier).state = value;
  }

  void addFavoriteArtist(Artist value) {
    _ref.read(favoriteArtistsProvider.notifier).state = [
      ...favoriteArtists,
      value,
    ];
  }

  void insertArtistsToList(List<Artist> userFavoriteArtists) {
    _ref.read(favoriteArtistsProvider.notifier).state = [
      ...userFavoriteArtists,
    ];
  }

  //送られてきたspotifyIdをもとに削除する
  void deleteFavoriteArtist(String value) {
    _ref.read(favoriteArtistsProvider.notifier).state = [
      ...favoriteArtists
          .where((favoriteArtist) => favoriteArtist.artistSpotifyId != value)
          .toList(),
    ];
  }

  Future<List<Artist>?> getUserFavoriteArtists() async {
    final userFavoriteArtists =
        await _artistFollowModel.getUserFavoriteArtists();
    //returnでuserFavoriteArtistsをリターンして、そこからinsertFirestorePostsToListと
    //データベースへの格納をすればいいのでは？
    if (userFavoriteArtists is List<Artist>) {
      return userFavoriteArtists;
    } else {
      return null;
    }
  }

  Future<void> followArtist({required Artist favoriteArtist}) async {
    addFavoriteArtist(favoriteArtist);
    await _artistFollowModel.addArtistToFavoriteArtists(
        followingArtist: favoriteArtist);
  }

  Future<void> unfollowArtist({required String favoriteArtistId}) async {
    deleteFavoriteArtist(favoriteArtistId);
    await _artistFollowModel.deleteArtistFromFavoriteArtists(
        followingArtistId: favoriteArtistId);
  }

  List<Artist> changeLocalUserFavoriteArtiststoFavoriteArtists(
      List<LocalUserFavoriteArtist> localUserFavoriteArtists) {
    final List<Artist> userFavoriteArtists = [];
    for (var localUserFavoriteArtist in localUserFavoriteArtists) {
      final favoriteArtist = Artist(
        artistSpotifyId: localUserFavoriteArtist.userFavoriteArtistId,
        artistImg: localUserFavoriteArtist.userFavoriteArtistImg,
        artistName: localUserFavoriteArtist.userFavoriteArtistName,
        spotifyArtistUrl: localUserFavoriteArtist.userFavoriteArtistSpotifyUrl,
      );
      userFavoriteArtists.add(favoriteArtist);
    }
    return userFavoriteArtists;
  }

  void resetFollowingArtistsProvider() {
    _ref.read(favoriteArtistsProvider.notifier).state = [];
  }
}
