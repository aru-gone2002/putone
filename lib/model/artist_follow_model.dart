import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/artist/artist.dart';

class ArtistFollowModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> getUserFavoriteArtists() async {
    final String uid = auth.currentUser!.uid;
    final List<Artist> userFavoriteArtists = [];
    try {
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('favoriteArtists')
          .get();
      for (var docSnapshot in response.docs) {
        //docSnapshot.data()を一つずつproviderに格納していく
        //①一回変数に全て入れて、それを返り値として返してから、providerに入れる。
        final userFavoriteArtist = Artist.fromJson(docSnapshot.data());
        userFavoriteArtists.add(userFavoriteArtist);
      }
      return userFavoriteArtists;
    } catch (e) {
      print('Error getting userFavorites from Firestore: $e');
    }
  }

  Future<void> addArtistToFavoriteArtists({
    required Artist followingArtist,
  }) async {
    final uid = auth.currentUser!.uid;
    final Map<String, dynamic> followingArtistMap = followingArtist.toJson();
    await firestore
        .collection('users')
        .doc(uid)
        .collection('favoriteArtists')
        .doc(followingArtist.artistSpotifyId)
        .set(followingArtistMap);
  }

  Future<void> deleteArtistFromFavoriteArtists({
    required String followingArtistId,
  }) async {
    final uid = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(uid)
        .collection('favoriteArtists')
        .doc(followingArtistId)
        .delete();
  }
}
