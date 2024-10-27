import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/model/item_model.dart';
import 'package:putone/providers/item_provider.dart';

class ItemViewModel {
  final ItemModel _itemModel = ItemModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<Item> get items => _ref.watch(myItemsProvider);

  Future<String?> onImageTapped({required Item item}) async {
    final XFile xFile = await _itemModel.getImageFromGallery();
    CroppedFile? croppedFile = await _itemModel.returnCroppedFile(xFile: xFile);
    //croppedFileがnullだったら特に何もしない。
    //CircleAvatarにbackgroundColorが表示されるだけ

    if (croppedFile != null) {
      final imgUrl = await _itemModel.uploadItemImgAndGetURL(
          croppedFile: croppedFile, item: item);
      // saveUserImg(imgUrl);
      return imgUrl;
    } else {
      return null;
    }
  }

  Future<void> deletePhotoData(String imgUrl) async {
    await _itemModel.deletePhotoData(imgUrl);
  }

  Future<void> sendItemToFirestore({required Item item}) async {
    await _itemModel.sendItemToFirestore(item: item);
  }
}
