import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/model/friends_quiz_model.dart';

class FriendsQuizViewModel {
  final FriendsQuizModel _friendsQuizModel = FriendsQuizModel();
  // late WidgetRef _ref;
  // void setRef(WidgetRef ref) {
  //   _ref = ref;
  // }

  Future<UserProfile?> getQuizUserProfile(String uid) async {
    final result = await _friendsQuizModel.getQuizUserProfile(uid);
    return result;
  }
}
