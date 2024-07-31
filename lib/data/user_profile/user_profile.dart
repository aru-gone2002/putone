// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'user_profile.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String userId,
    required String userName,
    required String userImg,
    required String themeMusicImg,
    required String themeMusicArtistName,
    required String themeMusicName,
    required String themeMusicSpotifyUrl,
    required String themeMusicPreviewUrl,
    required String userProfileMsg,
    required bool userSpotifyConnected,
    required int followingUserCount,
    required int followedUserCount,
    required DateTime userSignUpTimestamp,
    required DateTime userLastLoginTimestamp,
    required String communityId,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, Object?> json) =>
      _$UserProfileFromJson(json);
}
