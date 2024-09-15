import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/following_user/following_user.dart';
import 'package:putone/data/followed_user/followed_user.dart';

final followingUsersProvider = StateProvider<List<FollowingUser>>((ref) => []);

final followedUsersProvider = StateProvider<List<FollowedUser>>((ref) => []);

final followingNumProvider = StateProvider<int>((ref) => 0);

final followedNumProvider = StateProvider<int>((ref) => 0);
