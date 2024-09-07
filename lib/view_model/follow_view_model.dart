import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/model/follow_model.dart';
import 'package:putone/providers/follow_provider.dart';

class FollowViewModel {
  final FollowModel _followModel = FollowModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<FollowingUser> get followingUsers => _ref.read(followingUsersProvider);

  void saveFollowingUsers(List<FollowingUser> value) {
    _ref.read(followingUsersProvider.notifier).state = value;
  }

  Future<void> followUser({required String uid}) async {
    await _followModel.addUserToFollowings(uid: uid);
  }

  Future<void> unfollowUser({required String uid}) async {
    await _followModel.deleteUserFromFollowings(uid: uid);
  }

  Future<bool> isFollowing({required String uid}) async {
    return await _followModel.isFollowingUser(uid: uid);
  }

  Future<void> getFollowingUsers({required String followingUid}) async {
    final result =
        await _followModel.getFollowingUsers(followingUid: followingUid);
    if (result is List<FollowingUser>) {
      saveFollowingUsers(result);
    } else {
      print(result);
    }
  }
}
