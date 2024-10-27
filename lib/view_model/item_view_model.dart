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

  String get uid =>
      _ref.watch(temporaryItemProvider.select((value) => value.uid)).toString();

  String get itemId =>
      _ref.watch(temporaryItemProvider.select((value) => value.itemId));

  bool get isForSale =>
      _ref.watch(temporaryItemProvider.select((value) => value.isForSale));

  String get artistSpotifyId => _ref
      .watch(temporaryItemProvider.select((value) => value.artistSpotifyId));

  String get artistName =>
      _ref.watch(temporaryItemProvider.select((value) => value.artistName));

  String get artistSpotifyUrl => _ref
      .watch(temporaryItemProvider.select((value) => value.artistSpotifyUrl));

  List<String> get itemImgs =>
      _ref.watch(temporaryItemProvider.select((value) => value.itemImgs));

  String get itemName =>
      _ref.watch(temporaryItemProvider.select((value) => value.itemName));

  String get itemDiscription => _ref
      .watch(temporaryItemProvider.select((value) => value.itemDiscription));

  double get price =>
      _ref.watch(temporaryItemProvider.select((value) => value.price));

  String get size =>
      _ref.watch(temporaryItemProvider.select((value) => value.size));

  List<String> get categories =>
      _ref.watch(temporaryItemProvider.select((value) => value.categories));

  DateTime get createdAt =>
      _ref.watch(temporaryItemProvider.select((value) => value.createdAt));

  Item get temporaryItem => _ref.watch(temporaryItemProvider);

  void saveUid(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(uid: value);
  }

  void saveItemId(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(itemId: value);
  }

  void saveIsForSale(bool value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(isForSale: value);
  }

  void saveArtistSpotifyId(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(artistSpotifyId: value);
  }

  void saveArtistName(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(artistName: value);
  }

  void saveArtistSpotifyUrl(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(artistSpotifyUrl: value);
  }

  void saveItemImgs(List<String> value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(itemImgs: value);
  }

  void saveItemDiscription(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(itemDiscription: value);
  }

  void savePrice(double value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(price: value);
  }

  void saveSize(String value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(size: value);
  }

  void saveCategories(List<String> value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(categories: value);
  }

  void saveCreatedAt(DateTime value) {
    _ref.read(temporaryItemProvider.notifier).state =
        _ref.read(temporaryItemProvider).copyWith(createdAt: value);
  }

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
