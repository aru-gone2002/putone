import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/data/community/community.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/local_database.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/providers/community_provider.dart';
import 'package:putone/providers/spotify_access_provider.dart';
import 'package:putone/providers/user_profile_provider.dart';

class ProfileViewModel {
  final ProfileModel _profileModel = ProfileModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  String get uid =>
      _ref.watch(userProfileProvider.select((value) => value.uid)).toString();

  String get userId =>
      _ref.watch(userProfileProvider.select((value) => value.userId));

  String get userName =>
      _ref.watch(userProfileProvider.select((value) => value.userName));

  String get userImg =>
      _ref.watch(userProfileProvider.select((value) => value.userImg));

  String get themeMusicImg =>
      _ref.watch(userProfileProvider.select((value) => value.themeMusicImg));

  String get themeMusicArtistName => _ref
      .watch(userProfileProvider.select((value) => value.themeMusicArtistName));

  String get themeMusicName =>
      _ref.watch(userProfileProvider.select((value) => value.themeMusicName));

  String get themeMusicSpotifyUrl => _ref
      .watch(userProfileProvider.select((value) => value.themeMusicSpotifyUrl));

  String get themeMusicPreviewUrl => _ref
      .watch(userProfileProvider.select((value) => value.themeMusicPreviewUrl));

  String get userProfileMsg =>
      _ref.watch(userProfileProvider.select((value) => value.userProfileMsg));

  bool get userSpotifyConnected => _ref
      .watch(userProfileProvider.select((value) => value.userSpotifyConnected));

  DateTime get userLastLoginTimestamp => _ref.watch(
      userProfileProvider.select((value) => value.userLastLoginTimestamp));

  DateTime get userSignUpTimestamp => _ref
      .watch(userProfileProvider.select((value) => value.userSignUpTimestamp));

  String get communityId =>
      _ref.watch(userProfileProvider.select((value) => value.communityId));

  UserProfile get userProfile => _ref.read(userProfileProvider);

  Community get selectedCommunity => _ref.watch(selectedCommunityProvider);

  Map<String, Community> get communityMap => _ref.watch(communityMapProvider);

  String get spotifyAccessToken => _ref.watch(spotifyAccessTokenProvider);

  List<SpotifyTrack> get spotifySearchTracks =>
      _ref.watch(spotifySearchTracksProvider);

  void saveUid(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(uid: value);
  }

  void saveUserId(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userId: value);
  }

  void saveUserName(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userName: value);
  }

  void saveUserImg(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userImg: value);
  }

  void saveThemeMusicImg(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(themeMusicImg: value);
  }

  void saveThemeMusicArtistName(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(themeMusicArtistName: value);
  }

  void saveThemeMusicName(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(themeMusicName: value);
  }

  void saveThemeMusicSpotifyUrl(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(themeMusicSpotifyUrl: value);
  }

  void saveThemeMusicPreviewUrl(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(themeMusicPreviewUrl: value);
  }

  void saveUserProfileMsg(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userProfileMsg: value);
  }

  void saveUserSpotifyConnected(bool value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userSpotifyConnected: value);
  }

  void saveUserLastLoginTimestamp(DateTime value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userLastLoginTimestamp: value);
  }

  void saveCommunityId(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(communityId: value);
  }

  void saveUserProfile(UserProfile value) {
    _ref.read(userProfileProvider.notifier).state = value;
  }

  void saveSpotifyAccessToken(String value) {
    _ref.read(spotifyAccessTokenProvider.notifier).state = value;
  }

  void saveSpotifySearchTracks(List<SpotifyTrack> value) {
    _ref.read(spotifySearchTracksProvider.notifier).state = value;
  }

  void saveSelectedCommunity(Community value) {
    _ref.read(selectedCommunityProvider.notifier).state = value;
  }

  void resetUserProfileProvider() {
    saveUid('');
    saveUserId('');
    saveUserImg('');
    saveUserName('');
    saveUserProfileMsg('');
    saveThemeMusicArtistName('');
    saveThemeMusicName('');
    saveThemeMusicImg('');
    saveThemeMusicSpotifyUrl('');
    saveThemeMusicPreviewUrl('');
    //TODO userSignUpTimestampをどうするか
    saveCommunityId('none');
  }

  //ローカルDBにあるユーザーのプロフィール情報をproviderに格納する
  void saveUserProfileLocalDBData(LocalUserProfile value) {
    saveUid(value.uid);
    saveUserId(value.userId);
    saveUserName(value.userName);
    saveUserImg(value.userImg);
    saveThemeMusicImg(value.themeMusicImg);
    saveThemeMusicName(value.themeMusicName);
    saveThemeMusicArtistName(value.themeMusicArtistName);
    saveThemeMusicSpotifyUrl(value.themeMusicSpotifyUrl);
    //TODO ここのnullSafetyは確認しなければならない
    saveThemeMusicPreviewUrl(value.themeMusicPreviewUrl!);
    saveUserProfileMsg(value.userProfileMsg);
    saveUserSpotifyConnected(value.userSpotifyConnected);
    saveCommunityId(value.communityId);
  }

  Future<void> onImageTapped() async {
    final XFile xFile = await _profileModel.getImageFromGallery();
    CroppedFile? croppedFile =
        await _profileModel.returnCroppedFile(xFile: xFile);
    //croppedFileがnullだったら特に何もしない。
    //CircleAvatarにbackgroundColorが表示されるだけ
    if (croppedFile != null) {
      final imgUrl = await _profileModel.uploadProfileImgAndGetURL(
          uid: uid, croppedFile: croppedFile);
      saveUserImg(imgUrl);
    }
  }

  Future<void> fetchSpotifyAccessToken() async {
    final accessToken = await _profileModel.fetchAccessToken();
    if (accessToken != null) {
      saveSpotifyAccessToken(accessToken);
    }
  }

  Future<void> searchTracks({
    required String searchTrackName,
    required String searchArtistName,
  }) async {
    final List<SpotifyTrack> spotifyTracks = await _profileModel.searchTracks(
      accessToken: spotifyAccessToken,
      searchTrackName: searchTrackName,
      seachArtistName: searchArtistName,
    );
    saveSpotifySearchTracks(spotifyTracks);
  }

  void setThemeSong({required SpotifyTrack track}) {
    saveThemeMusicName(track.trackName);
    saveThemeMusicArtistName(track.artistName);
    saveThemeMusicImg(track.trackImg);
    saveThemeMusicSpotifyUrl(track.trackExternalUrl);
    saveThemeMusicPreviewUrl(track.previewUrl ?? '');
  }

  Future<void> setUserProfileToFirestore() async {
    _profileModel.setUserProfileToFirestore(userProfile: userProfile);
  }

  Future<void> addUserToCommunity() async {
    await _profileModel.addUserToCommunity(uid: uid, communityId: communityId);
  }

  Future<void> getUserProfile(String uid) async {
    final userProfile = await _profileModel.getUserProfile(uid);
    if (userProfile != null) {
      saveUserProfile(userProfile);
    }
  }

  Future<void> updateFirestoreUserName({required String newUserName}) async {
    await _profileModel.updateFirestoreUserName(
        uid: uid, newUserName: newUserName);
  }

  Future<void> updateFirestoreUserId({required String newUserId}) async {
    await _profileModel.updateFirestoreUserId(
      uid: uid,
      newUserId: newUserId,
    );
  }

  Future<void> updateFirestoreThemeMusicInfo(
      {required SpotifyTrack spotifyTrack}) async {
    await _profileModel.updateFirestoreThemeMusicInfo(
        uid: uid, spotifyTrack: spotifyTrack);
  }
}
