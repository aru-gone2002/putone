import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/model/community_model.dart';

class CommunityViewModel {
  final CommunityModel _communityModel = CommunityModel();

  Future<List<UserProfile>?> getCommunityUsers(
      {required String communityId}) async {
    return await _communityModel.getCommunityUsers(communityId: communityId);
  }

  Future<List<Artist>?> getFavoriteArtists({required String uid}) async {
    return await _communityModel.getFavoriteArtists(uid: uid);
  }
}
