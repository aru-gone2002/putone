import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';

class ItemModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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

  Future<String> uploadItemImgAndGetURL(
      {required CroppedFile croppedFile}) async {
    final profileImgFile = File(croppedFile.path);
    final String fileName = returnJpgFileName();
    final Reference storageRef = storage
        .ref()
        .child("items")
        .child(auth.currentUser!.uid)
        .child(fileName);
    await storageRef.putFile(profileImgFile);
    return await storageRef.getDownloadURL();
  }

  Future<void> deletePhotoData(String imgUrl) async {
    final storageReference = storage.refFromURL(imgUrl);
    await storageReference.delete();
  }
}
