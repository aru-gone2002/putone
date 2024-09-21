import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/enums.dart';
import 'package:putone/data/post_answer/post_answer.dart';

final getFollowingUsersPostConditionProvider =
    StateProvider<Enum>((ref) => GetFollowingUsersPostsCondition.lackOfFriends);

final postAnswersProvider = StateProvider<List<PostAnswer>>((ref) => []);
