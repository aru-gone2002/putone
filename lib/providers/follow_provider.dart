import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/following_user/following_user.dart';

final followingUsersProvider = StateProvider<List<FollowingUser>>((ref) => []);

final followingNumProvider = StateProvider<int>((ref) => 0);

final followerNumProvider = StateProvider<int>((ref) => 0);
