import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:http/http.dart' as http;

class ProfileModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  String getUid() {
    final uid = auth.currentUser!.uid;
    return uid;
  }

  Future<XFile> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 100);
    return image!;
  }

  Future<CroppedFile?> returnCroppedFile({required XFile? xFile}) async {
    final instance = ImageCropper();
    final CroppedFile? croppedFile = await instance.cropImage(
      sourcePath: xFile!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: cropperTitle,
            toolbarColor: AppColorTheme.color().mainColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(title: cropperTitle),
      ],
    );

    return croppedFile;
  }

  Future<String> uploadProfileImgAndGetURL(
      {required String uid, required CroppedFile croppedFile}) async {
    final profileImgFile = File(croppedFile.path);
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    print('uid(uploadProfileImgAndGetURL):$uid');
    print('uid(model):${auth.currentUser!.uid}');
    await storageRef.putFile(profileImgFile);
    return await storageRef.getDownloadURL();
  }

  Future<String?> fetchAccessToken() async {
    const host = 'accounts.spotify.com';
    const tokenEndPoint = '/api/token';
    final String clientId = dotenv.get('SPOTIFY_API_CLIENT_ID');
    final String clientSecret = dotenv.get('SPOTIFY_CLIENT_SEACRET');
    final Map<String, String> requestBody = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    final url = Uri.https(host, tokenEndPoint);
    print('url: $url');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    try {
      final response =
          await http.post(url, body: requestBody, headers: headers);
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      return accessToken;
    } catch (e) {
      //TODO 処理を入れる
      print(e.toString());
      return null;
    }
  }

  Future<void> _getArtist(String? accessToken) async {
    // Replace with your actual access token

    // Set the base URL for Spotify API
    final String baseUrl = 'https://api.spotify.com/v1';

    // Specify the artist ID
    final String artistId = '4QvgGvpgzgyUOo8Yp8LDm9?si=uhLfYaonSl6wOe9rM6Gmuw';

    // Construct the full API endpoint URL
    final String endpointUrl = '$baseUrl/artists/$artistId';

    // Create the HTTP request headers
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // Send the GET request to the Spotify API
    final response = await http.get(
      Uri.parse(endpointUrl),
      headers: headers,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> artistData = jsonDecode(response.body);

      // Print the artist's name
      print('Artist Name: ${artistData['name']}');
      print(artistData);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<List<SpotifyTrack>> searchTracks({
    required String accessToken,
    required String searchTrackName,
    required String seachArtistName,
  }) async {
    const String searchEndPoint = 'https://api.spotify.com/v1/search';
    const String searchType = 'type=track';
    const String limit = 'limit=20';
    String trackFilter = '';
    String artistFilter = '';
    String query = '';

    //返す楽曲のリスト
    List<SpotifyTrack> searchResponseTrackList = [];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    //検索の際に曲名が書かれているかでクエリの中身を変更
    //日本語でもqueryを反応できるようにencodeQueryComponentを行う
    if (searchTrackName != '') {
      String trackEncodedQuery = Uri.encodeQueryComponent(searchTrackName);
      trackFilter = 'track%3A$trackEncodedQuery';
      //trackFilter = 'track%3A$searchTrackName';
    }

    //検索の際にアーティスト名が書かれているかでクエリの中身を変更
    //日本語でもqueryを反応できるようにencodeQueryComponentを行う
    if (seachArtistName != '') {
      String artistEncodedQuery = Uri.encodeQueryComponent(seachArtistName);
      artistFilter = 'artist%3A$artistEncodedQuery';
      //artistFilter = 'artist%3A$seachArtistName';
    }

    //書き込まれているかでクエリを分岐
    if (seachArtistName == '' && searchTrackName != '') {
      query = 'q=$trackFilter';
    } else if (seachArtistName != '' && searchTrackName == '') {
      query = 'q=$artistFilter';
    } else if (seachArtistName != '' && searchTrackName != '') {
      query = 'q=$trackFilter&$artistFilter';
    }

    //リクエストのURL
    final String endPointUrl = '$searchEndPoint?$query&$searchType&$limit';

    //http.getで楽曲を検索
    final response = await http.get(
      Uri.parse(endPointUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> trackData = jsonDecode(response.body);
      final List<dynamic> tracks = trackData['tracks']['items'];

      for (int i = 0; i < tracks.length; i++) {
        final String trackImg = tracks[i]['album']['images'][2]['url'];
        final String artistName = tracks[i]['artists'][0]['name'];
        final String trackName = tracks[i]['name'];
        final String trackExternalUrl = tracks[i]['external_urls']['spotify'];
        final String? previewUrl = tracks[i]['preview_url'];
        final SpotifyTrack spotifyTrack = SpotifyTrack(
          trackImg: trackImg,
          artistName: artistName,
          trackName: trackName,
          trackExternalUrl: trackExternalUrl,
          previewUrl: previewUrl ?? '',
        );
        print('アーティスト名: $artistName');
        searchResponseTrackList.add(spotifyTrack);
      }

      return searchResponseTrackList;
    } else {
      print('Spotify API Error: ${response.statusCode}');
      return searchResponseTrackList;
    }
  }

  Future<void> uploadProfileInfo({required UserProfile userProfile}) async {
    final userProfileMap = userProfile.toJson();
    await firestore
        .collection('users')
        .doc(userProfile.uid)
        .set(userProfileMap);
  }

  Future<void> addUserToCommunity(
      {required String uid, required String communityId}) async {
    final Map<String, dynamic> communityUserId = {'uid': uid};
    await firestore
        .collection('communities')
        .doc(communityId)
        .collection('users')
        .doc(uid)
        .set(communityUserId);
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final response = await firestore.collection('users').doc(uid).get();
      final responseData = response.data() as Map<String, dynamic>;
      final userProfile = UserProfile.fromJson(responseData);
      return userProfile;
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Future<void> addUserProfiletoLocalDB(UserProfile userProfile) async {
    // into(UserBaseProfiles).insert(
    //   UserBaseProfilesCompanion(
    //     uid: Value(userProfile.uid),
    //     userId: Value(userProfile.userId),
    //     userName: Value(userProfile.userName),
    //     userImg: Value(userProfile.userImg),
    //     themeMusicImg: Value(userProfile.themeMusicImg),
    //     themeMusicArtistName: Value(userProfile.themeMusicArtistName),
    //     themeMusicSpotifyUrl: Value(userProfile.themeMusicSpotifyUrl),
    //     themeMusicPreviewUrl: Value(userProfile.themeMusicPreviewUrl),
    //     userProfileMsg: Value(userProfile.userProfileMsg),
    //     userSpotifyConnected: Value(userProfile.userSpotifyConnected),
    //     communityId: Value(userProfile.communityId),
    //   ),
    // );
  }

  Future<void> setUserProfileToFirestore(
      {required String uid, required UserProfile userProfile}) async {
    final userProfileMap = userProfile.toJson();
    await firestore.collection('users').doc(uid).set(userProfileMap);
  }
}
