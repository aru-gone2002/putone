import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';

class ProfileModel {
  FirebaseAuth auth = FirebaseAuth.instance;

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
}
