import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';

final postProvider = StateProvider<Post>(
  (ref) => Post(
    uid: '',
    postId: '',
    postMusicImg: '',
    postMusicArtistName: '',
    postMusicName: '',
    postMsg: '',
    postTimestamp: DateTime.now(),
    postMusicSpotifyUrl: '',
    postMusicPreviewUrl: '',
    //postLikeCount: 0,
  ),
);

final postsProvider = StateProvider<List<Post>>((ref) => []);

final tempPostProvider = StateProvider<Post>(
  (ref) => Post(
    uid: '',
    postId: '',
    postMusicImg: '',
    postMusicArtistName: '',
    postMusicName: '',
    postMsg: '',
    postTimestamp: DateTime.now(),
    postMusicSpotifyUrl: '',
    postMusicPreviewUrl: '',
  ),
);

final tempPostsProvider = StateProvider<List<Post>>((ref) => []);

final followingUsersPostsProvider = StateProvider<List<Post>>((ref) => []);
