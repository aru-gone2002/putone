import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/local_database.dart';

final userProfileProvider = StateProvider<UserProfile>(
  (ref) => UserProfile(
    uid: '',
    userId: '',
    userImg: '',
    userName: '',
    userProfileMsg: '',
    themeMusicName: '',
    themeMusicArtistName: '',
    themeMusicImg: '',
    themeMusicSpotifyUrl: '',
    themeMusicPreviewUrl: '',
    userSpotifyConnected: false,
    userSignUpTimestamp: DateTime.now(),
    userLastLoginTimestamp: DateTime.now(),
    communityId: 'none',
  ),
);

final appDataBaseProvider = StateProvider<AppDatabase?>((ref) => null);
