import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/followed_user/followed_user.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/model/follow_model.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/providers/follow_provider.dart';

class FollowViewModel {
  final FollowModel _followModel = FollowModel();
  final ProfileModel _profileModel = ProfileModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<FollowingUser> get followingUsers => _ref.read(followingUsersProvider);

  List<FollowedUser> get followedUsers => _ref.read(followedUsersProvider);

  List<FollowingUser> get friendFollowingUsers =>
      _ref.read(friendFollowingUsersProvider);

  List<FollowedUser> get friendFollowedUsers =>
      _ref.read(friendFollowedUsersProvider);

  int get followingNum => _ref.read(followingNumProvider);

  int get followedNum => _ref.read(followedNumProvider);

  int get friendFollowingNum => _ref.read(friendFollowingNumProvider);

  int get friendFollowedNum => _ref.read(friendFollowedNumProvider);

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

  void saveFriendFollowingUsers(List<FollowingUser> value) {
    _ref.read(friendFollowingUsersProvider.notifier).state = value;
  }

  void saveFriendFollowedUsers(List<FollowedUser> value) {
    _ref.read(friendFollowedUsersProvider.notifier).state = value;
  }

  void saveFriendFollowingNum(int value) {
    _ref.read(friendFollowingNumProvider.notifier).state = value;
  }

  void saveFriendFollowedNum(int value) {
    _ref.read(friendFollowedNumProvider.notifier).state = value;
  }

  void resetAllFollowProviders() {
    saveFollowedNum(0);
    saveFollowedUsers([]);
    saveFollowingNum(0);
    saveFollowingUsers([]);
    saveFriendFollowedNum(0);
    saveFriendFollowedUsers([]);
    saveFriendFollowingNum(0);
    saveFriendFollowingUsers([]);
  }

  void addFollowingUser(FollowingUser value) {
    List<FollowingUser> newFollowingUsers = [...followingUsers, value];
    saveFollowingUsers(newFollowingUsers);
    saveFollowingNum(newFollowingUsers.length);
    print('Followings: ${newFollowingUsers.length}');
  }

  void deleteFollowingUser(String value) {
    List<FollowingUser> newFollowingUsers = [
      ...followingUsers
          .where((followingUser) => followingUser.followingUid != value)
          .toList(),
    ];
    saveFollowingUsers(newFollowingUsers);
    saveFollowingNum(newFollowingUsers.length);
    print('Followings: ${newFollowingUsers.length}');
  }

  Future<void> followUser({required FollowingUser followingUser}) async {
    addFollowingUser(followingUser);

    //自分のフォロー中に友達を追加する
    await _followModel.addUserToFollowings(followingUser: followingUser);

    //友達のフォロワーに自分自身を追加する
    await _followModel.addSelfToFriendsFollowers(
        friendsUid: followingUser.followingUid);
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

  Future<void> getFollowingUsers(String uid) async {
    final result = await _followModel.getFollowingUsers(uid);
    if (result is List<FollowingUser>) {
      print('followingUsers: $result');
      saveFollowingUsers(result);
      saveFollowingNum(result.length);
    } else {
      print(result);
    }
  }

  Future<void> getFollowingNum(String uid) async {
    final followingNum = await _followModel.getFollowingNum(uid);
    saveFollowingNum(followingNum);
  }

  Future<void> getFollowedUsers(String uid) async {
    final result = await _followModel.getFollowedUsers(uid);
    if (result is List<FollowedUser>) {
      saveFollowedUsers(result);
      saveFollowedNum(result.length);
    } else {
      print(result);
    }
  }

  Future<void> getFollowedNum(String uid) async {
    final followedNum = await _followModel.getFollowedNum(uid);
    saveFollowedNum(followedNum);
  }

  Future<List<FollowingUser>> getFriendFollowingUsers(String uid) async {
    final result = await _followModel.getFollowingUsers(uid);
    print(result);
    if (result is List<FollowingUser>) {
      return result;
    }
    if (result == null) {
      return [];
    }
  }

  Future<int> getFriendFollowingNum(String uid) async {
    final followingNum = await _followModel.getFollowingNum(uid);
    //saveFriendFollowingNum(followingNum);
    print('Following: $followingNum');
    return followingNum;
  }

  Future<List<FollowedUser>> getFriendFollowedUsers(String uid) async {
    final result = await _followModel.getFollowedUsers(uid);
    print(result);
    return result;
  }

  Future<int> getFriendFollowedNum(String uid) async {
    final followedNum = await _followModel.getFollowedNum(uid);
    //saveFriendFollowedNum(followedNum);
    print('Follower: $followedNum');
    return followedNum;
  }

  Future<UserProfile> getUserProfile(String uid) async {
    final userProfile = await _profileModel.getUserProfile(uid);
    return userProfile!;
  }
}
