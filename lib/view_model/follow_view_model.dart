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
  int get followingNum => _ref.read(followingNumProvider);
  int get followerNum => _ref.read(followerNumProvider);

  void saveFollowingUsers(List<FollowingUser> value) {
    _ref.read(followingUsersProvider.notifier).state = value;
  }

  void saveFollowingNum(int value) {
    _ref.read(followingNumProvider.notifier).state = value;
  }

  void addFollowingUser(FollowingUser value) {
    List<FollowingUser> newFollowingUsers = [...followingUsers, value];
    _ref.read(followingUsersProvider.notifier).state = newFollowingUsers;
    _ref.read(followingNumProvider.notifier).state = newFollowingUsers.length;
    print('Followings: ${newFollowingUsers.length}');
  }

  void deleteFollowingUser(String value) {
    List<FollowingUser> newFollowingUsers = [
      ...followingUsers
          .where((followingUser) => followingUser.followingUid != value)
          .toList(),
    ];
    _ref.read(followingUsersProvider.notifier).state = newFollowingUsers;
    _ref.read(followingNumProvider.notifier).state = newFollowingUsers.length;
    print('Followings: ${newFollowingUsers.length}');
  }

  Future<void> followUser({required FollowingUser followingUser}) async {
    addFollowingUser(followingUser);
    await _followModel.addUserToFollowings(followingUser: followingUser);
  }

  Future<void> unfollowUser({required String followingUid}) async {
    deleteFollowingUser(followingUid);
    await _followModel.deleteUserFromFollowings(followingUid: followingUid);
  }

  Future<bool> isFollowing({required String uid}) async {
    return await _followModel.isFollowingUser(followingUid: '');
  }

  Future<void> getFollowingUsers() async {
    final result = await _followModel.getFollowingUsers();
    if (result is List<FollowingUser>) {
      saveFollowingUsers(result);
    } else {
      print(result);
    }
  }

  Future<void> getFollowingNum() async {
    final followingNum = await _followModel.getFollowingNum();
    saveFollowingNum(followingNum);
  }
}
