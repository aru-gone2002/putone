import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/model/auth_model.dart';
import 'package:putone/model/profile_model.dart';
import 'package:putone/providers/spotify_access_provider.dart';
import 'package:putone/providers/user_auth_provider.dart';
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

  String get userProfileMsg =>
      _ref.watch(userProfileProvider.select((value) => value.userProfileMsg));

  int get followingUserCount => _ref
      .watch(userProfileProvider.select((value) => value.followingUserCount));

  int get followedUserCount => _ref
      .watch(userProfileProvider.select((value) => value.followedUserCount));

  bool get userSpotifyConnected => _ref
      .watch(userProfileProvider.select((value) => value.userSpotifyConnected));

  DateTime get userLastLoginTimestamp => _ref.watch(
      userProfileProvider.select((value) => value.userLastLoginTimestamp));

  DateTime get userSignUpTimestamp => _ref
      .watch(userProfileProvider.select((value) => value.userSignUpTimestamp));

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

  void saveUserProfileMsg(String value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userProfileMsg: value);
  }

  void saveFollowingUserCount(int value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(followingUserCount: value);
  }

  void saveFollowedUserCount(int value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(followedUserCount: value);
  }

  void saveUserSpotifyConnected(bool value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userSpotifyConnected: value);
  }

  void saveUserLastLoginTimestamp(DateTime value) {
    _ref.read(userProfileProvider.notifier).state =
        _ref.read(userProfileProvider).copyWith(userLastLoginTimestamp: value);
  }

  void saveSpotifyAccessToken(String value) {
    _ref.read(spotifyAccessTokenProvider.notifier).state = value;
  }

  void saveSpotifySearchTracks(List<SpotifyTrack> value) {
    _ref.read(spotifySearchTracksProvider.notifier).state = value;
  }

  Future<void> onImageTapped() async {
    final XFile xFile = await _profileModel.getImageFromGallery();
    CroppedFile? croppedFile =
        await _profileModel.returnCroppedFile(xFile: xFile);
    //croppedFileがnullだったら特に何もしない。
    //CircleAvatarにbackgroundColorが表示されるだけ
    if (croppedFile != null) {
      print(uid);
      final imgUrl = await _profileModel.uploadProfileImgAndGetURL(
          uid: uid, croppedFile: croppedFile);
      saveUserImg(imgUrl);
    }
  }

  Future<void> fetchAccessToken() async {
    final accessToken = await _profileModel.fetchAccessToken();
    if (accessToken != null) {
      saveSpotifyAccessToken(accessToken);
      print('accessToken: $accessToken');
    }
  }

  Future<void> searchTracks(
      {required String searchTrackName,
      required String searchArtistName}) async {
    final List<SpotifyTrack> spotifyTracks = await _profileModel.searchTracks(
      accessToken: spotifyAccessToken,
      searchTrackName: searchTrackName,
      seachArtistName: searchArtistName,
    );
    saveSpotifySearchTracks(spotifyTracks);
  }
}
