import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/local_database.dart';
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

  void addNewPostToList() {
    _ref.read(postsProvider.notifier).state = [
      ..._ref.read(postsProvider.notifier).state,
      newPost
    ];
  }

  Future<void> uploadPost() async {
    await _postModel.uploadNewPost(post: newPost);
  }

  void insertPostsToList(List<Post> userPosts) {
    _ref.read(postsProvider.notifier).state = [
      ...userPosts,
    ];
  }

  Future<List<Post>?> getUserPosts(String authUid) async {
    final userPosts = await _postModel.getUserPosts(authUid);
    //returnでuserPostsをリターンして、そこからinsertFirestorePostsToListと
    //データベースへの格納をすればいいのでは？
    if (userPosts is List<Post>) {
      return userPosts;
    } else {
      return null;
    }
  }

  List<Post> changeLocalUserPoststoPosts(List<LocalUserPost> localUserPosts) {
    final List<Post> userPosts = [];
    for (var localUserPost in localUserPosts) {
      final post = Post(
        uid: localUserPost.uid,
        postId: localUserPost.postId,
        postMusicImg: localUserPost.postMusicImg,
        postMusicArtistName: localUserPost.postMusicArtistName,
        postMusicName: localUserPost.postMusicName,
        postMsg: localUserPost.postMsg,
        postTimestamp: localUserPost.postTimestamp,
        postMusicSpotifyUrl: localUserPost.postMusicSpotifyUrl,
        postMusicPreviewUrl: localUserPost.postMusicPreciewUrl ?? '',
      );
      userPosts.add(post);
    }
    return userPosts;
  }

  void resetPostProvider() {
    saveUid('');
    savePostId('');
    savePostMusicImg('');
    savePostMusicArtistName('');
    savePostMusicName('');
    savePostMsg('');
    savePostTimestamp(DateTime.now());
    savePostMusicSpotifyUrl('');
    savePostMusicPreviewUrl('');
  }

  void resetPostsProvider() {
    _ref.read(postsProvider.notifier).state = [];
  }
}
