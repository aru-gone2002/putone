import 'package:putone/model/follow_model.dart';

class FollowViewModel {
  final FollowModel _followModel = FollowModel();

  Future<void> followUser({required String uid}) async {
    _followModel.addUserToFollowings(uid: uid);
  }

  Future<void> unfollowUser({required String uid}) async {
    _followModel.deleteUserFromFollowings(uid: uid);
  }

  Future<bool> isFollowing({required String uid}) async {
    return _followModel.isFollowingUser(uid: uid);
  }
}
