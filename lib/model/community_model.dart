import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class CommunityModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserProfile>?> getCommunityUsers(
      {required String communityId}) async {
    final List<String> communityUserIds = [];
    final List<UserProfile> communityUsers = [];
    try {
      final communityMemberUids = await firestore
          .collection('communities')
          .doc(communityId)
          .collection('users')
          .get();
      for (var docSnapshot in communityMemberUids.docs) {
        final memberUid = docSnapshot.data()['uid'];
        //自分のuidは含めない
        if (memberUid != auth.currentUser!.uid) {
          communityUserIds.add(memberUid);
        }
      }
      if (communityUserIds.isEmpty) {
        return [];
      }
      for (var memberUid in communityUserIds) {
        final memberProfile =
            await firestore.collection('users').doc(memberUid).get();
        if (memberProfile.exists) {
          final userData = UserProfile.fromJson(memberProfile.data()!);
          communityUsers.add(userData);
        }
      }
      return communityUsers;
    } catch (e) {
      print('Error getting communityUsers from Firestore: $e');
      return null;
    }
  }

  Future<List<Artist>?> getFavoriteArtists({required String uid}) async {
    final List<Artist> favoriteArtists = [];
    try {
      final response = await firestore
          .collection('users')
          .doc(uid)
          .collection('favoriteArtists')
          .get();
      if (response.docs.isEmpty) {
        return [];
      }
      for (var docSnapshot in response.docs) {
        final favoriteArtist = Artist.fromJson(docSnapshot.data());
        favoriteArtists.add(favoriteArtist);
      }
      return favoriteArtists;
    } catch (e) {
      print('Error getting favoriteArtists from Firestore: $e');
      return null;
    }
  }
}
