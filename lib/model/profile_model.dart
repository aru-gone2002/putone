import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/data/user_profile/user_profile.dart';
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
        source: ImageSource.gallery, imageQuality: 100, maxWidth: 400);
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
    await storageRef.putFile(profileImgFile);
    return await storageRef.getDownloadURL();
  }

  Future<void> setUserProfileToFirestore(
      {required UserProfile userProfile}) async {
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
      print('Error getting userProfile from Firestore: $e');
    }
  }

  // ----Firestoreを一項目ずつupdate----
  Future<void> updateFirestoreUserName({
    required String uid,
    required String newUserName,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'userName': newUserName});
    } catch (e) {
      print('Error update userName in Firestore: $e');
    }
  }

  Future<void> updateFirestoreUserId({
    required String uid,
    required String newUserId,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'userId': newUserId});
    } catch (e) {
      print('Error update userId in Firestore: $e');
    }
  }

  Future<void> updateFirestoreUserImg({
    required String uid,
    required String newUserImg,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'userImg': newUserImg});
    } catch (e) {
      print('Error update userId in Firestore: $e');
    }
  }

  Future<void> updateFirestoreThemeMusicInfo({
    required String uid,
    required SpotifyTrack spotifyTrack,
  }) async {
    try {
      await firestore.collection('users').doc(uid).update({
        'themeMusicImg': spotifyTrack.trackImg,
        'themeMusicArtistName': spotifyTrack.artistName,
        'themeMusicName': spotifyTrack.trackName,
        'themeMusicSpotifyUrl': spotifyTrack.trackExternalUrl,
        'themeMusicPreviewUrl': spotifyTrack.previewUrl,
      });
    } catch (e) {
      print('Error update themeSongInfo in Firestore: $e');
    }
  }

  Future<void> updateFirestoreCommunityId({
    required String uid,
    required String newCommunityId,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'communityId': newCommunityId});
    } catch (e) {
      print('Error update communityId in Firestore: $e');
    }
  }

  Future<void> deleteUserFromCommunity(
      {required String uid, required String communityId}) async {
    await firestore
        .collection('communities')
        .doc(communityId)
        .collection('users')
        .doc(uid)
        .delete();
  }

  Future<void> updateFirestoreUserProfileMsg({
    required String uid,
    required String newUserProfileMsg,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'userProfileMsg': newUserProfileMsg});
    } catch (e) {
      print('Error update userProfileMsg in Firestore: $e');
    }
  }

  // Stream<QuerySnapshot> checkUserIdIdentification(String userId) {
  //   //usersコレクションにあるドキュメントのうち、
  //   return firestore
  //       .collection('users')
  //       .where('userId', isEqualTo: userId)
  //       .snapshots();
  // }

  Future<bool> checkUserIdIdentification(String userId) async {
    final response = await firestore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    final isUserIdAvailable = response.docs.isEmpty;
    return isUserIdAvailable;
  }
}
