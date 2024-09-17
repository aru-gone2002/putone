import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/enums.dart';

final getFollowingUsersPostConditionProvider =
    StateProvider<Enum>((ref) => GetFollowingUsersPostsCondition.lackOfFriends);
