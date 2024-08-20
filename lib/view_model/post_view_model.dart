import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/model/post_model.dart';
import 'package:putone/providers/post_provider.dart';

class PostViewModel {
  final PostModel _postModel = PostModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  String get uid => _ref.watch(postProvider.select((value) => value.uid));

  String get postId => _ref.watch(postProvider.select((value) => value.postId));

  String get postMusicImg =>
      _ref.watch(postProvider.select((value) => value.postMusicImg));

  String get postMusicArtistName =>
      _ref.watch(postProvider.select((value) => value.postMusicArtistName));

  String get postMusicName =>
      _ref.watch(postProvider.select((value) => value.postMusicName));

  String get postMsg =>
      _ref.watch(postProvider.select((value) => value.postMsg));

  DateTime get postTimestamp =>
      _ref.watch(postProvider.select((value) => value.postTimestamp));

  String get postMusicSpotifyUrl =>
      _ref.watch(postProvider.select((value) => value.postMusicSpotifyUrl));

  String get postMusicPreviewUrl =>
      _ref.watch(postProvider.select((value) => value.postMusicPreviewUrl));

  int get postLikeCount =>
      _ref.watch(postProvider.select((value) => value.postLikeCount));

  Post get newPost => _ref.watch(postProvider);

  List<Post> get posts => _ref.watch(postsProvider);

  void saveUid(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(uid: value);
  }

  void savePostId(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postId: value);
  }

  void savePostMusicImg(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMusicImg: value);
  }

  void savePostMusicArtistName(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMusicArtistName: value);
  }

  void savePostMusicName(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMusicName: value);
  }

  void savePostMsg(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMsg: value);
  }

  void savePostTimestamp(DateTime value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postTimestamp: value);
  }

  void savePostMusicSpotifyUrl(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMusicSpotifyUrl: value);
  }

  void savePostMusicPreviewUrl(String value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postMusicPreviewUrl: value);
  }

  void savePostLikeCount(int value) {
    _ref.read(postProvider.notifier).state =
        _ref.read(postProvider).copyWith(postLikeCount: value);
  }

  void addNewPostToList() {
    _ref.read(postsProvider.notifier).state = [
      ..._ref.read(postsProvider.notifier).state,
      newPost
    ];
  }

  Future<void> uploadPost() async {
    await _postModel.uploadNewPost(post: newPost);
  }
}
