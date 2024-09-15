import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/followed_user/followed_user.dart';
import 'package:putone/model/follow_model.dart';
import 'package:putone/providers/follow_provider.dart';

class FollowViewModel {
  final FollowModel _followModel = FollowModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<FollowingUser> get followingUsers => _ref.read(followingUsersProvider);
  List<FollowedUser> get followedUsers => _ref.read(followedUsersProvider);
  int get followingNum => _ref.read(followingNumProvider);
  int get followedNum => _ref.read(followedNumProvider);

  void saveFollowingUsers(List<FollowingUser> value) {
    _ref.read(followingUsersProvider.notifier).state = value;
  }

  void saveFollowedUsers(List<FollowedUser> value) {
    _ref.read(followedUsersProvider.notifier).state = value;
  }

  void saveFollowingNum(int value) {
    _ref.read(followingNumProvider.notifier).state = value;
  }

  void saveFollowedNum(int value) {
    _ref.read(followedNumProvider.notifier).state = value;
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

    //友達のフォロワーに自分自身を追加する
    await _followModel.addSelfToFriendsFollowers(
        friendsUid: followingUser.followingUid);
    //自分のフォロー中に友達を追加する
    await _followModel.addUserToFollowings(followingUser: followingUser);
  }

  Future<void> unfollowUser({required String followingUid}) async {
    deleteFollowingUser(followingUid);

    //友達のフォロワーから自分自身を削除する
    await _followModel.deleteSelfFromFriendsFollowers(friendsUid: followingUid);
    //自分のフォロー中から友達を削除する
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

  Future<void> getFollowedUsers() async {
    final result = await _followModel.getFollowedUsers();
    if (result is List<FollowedUser>) {
      saveFollowedUsers(result);
    } else {
      print(result);
    }
  }

  Future<void> getFollowedNum() async {
    final followedNum = await _followModel.getFollowedNum();
    saveFollowedNum(followedNum);
  }
}
