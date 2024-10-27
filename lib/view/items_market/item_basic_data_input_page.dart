import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:putone/constants/doubles.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/validators.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/button/circular_button.dart';
import 'package:putone/view_model/item_view_model.dart';

class ItemBasicDataInputPage extends ConsumerWidget {
  const ItemBasicDataInputPage({super.key, required this.item});

  final ValueNotifier<Item> item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemViewModel itemViewModel = ItemViewModel();
    itemViewModel.setRef(ref);
    final formKey = GlobalObjectKey<FormState>(context);

    Future<void> onImageTapped({required int index}) async {
      final imgResult = await itemViewModel.onImageTapped(item: item.value);
      if (imgResult != null) {
        //TODO 本当はここでStorageに写真を入れず、最後に確定したタイミングで入れるようにしたい。
        await itemViewModel.deletePhotoData(item.value.itemImgs[index]);
        item.value.itemImgs.remove(index);
        item.value.itemImgs.insert(index, imgResult);
      }
    }

    Future<void> submitItemBasicDataFunction() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //TODO ItemSaleDataInputPageに遷移する。
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: spaceHeightMedium,
              right: spaceWidthMedium,
              top: spaceHeightSmall,
              bottom: spaceHeightMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Artist Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.value.artistName,
                style: TextStyle(
                  color: AppColorTheme.color().gray1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Images (Max 4)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () => onImageTapped(index: index),
                    child: item.value.itemImgs[index] != ''
                        ? ExtendedImage.network(
                            item.value.itemImgs[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: const Icon(Icons.add_a_photo),
                          ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Itemの名前
                    const Text(
                      'Item Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: itemNameValidator,
                      onSaved: (value) {
                        item.value == item.value.copyWith(itemName: value!);
                      },
                      maxLines: 2,
                      maxLength: maxItemNameLength,
                      //expands: true,
                      cursorColor: AppColorTheme.color().mainColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        isDense: true,
                        hintText: writeItemNameHintText,
                        hintStyle: TextStyle(
                          color: AppColorTheme.color().gray1,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColorTheme.color().gray1,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColorTheme.color().mainColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //アイテムのDiscription
                    const Text(
                      'Discription',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: itemDiscriptionValidator,
                      onSaved: (value) {
                        item.value == item.value.copyWith(itemName: value!);
                      },
                      maxLines: 8,
                      maxLength: maxItemDiscriptionLength,
                      //expands: true,
                      cursorColor: AppColorTheme.color().mainColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        isDense: true,
                        hintText: writeItemDiscriptionHintText,
                        hintStyle: TextStyle(
                          color: AppColorTheme.color().gray1,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColorTheme.color().gray1,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColorTheme.color().mainColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),
              item.value.isForSale
                  ? CircularButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          //TODO ItemsSalesDataInputPageに遷移する
                          if (context.mounted) {
                            // toItemsMarketPage(context: context);
                          }
                        }
                      },
                      text: nextProgressBtnText,
                      btnColor: AppColorTheme.color().gray1,
                      fontColor: Colors.white,
                      fontSize: fontMedium,
                      hasBorder: false,
                    )
                  : CircularButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          //ここでFirestoreにアイテムを登録する。
                          await itemViewModel.sendItemToFirestore(
                              item: item.value);

                          //ItemsMarketPageに遷移する
                          if (context.mounted) {
                            toItemsMarketPage(context: context);
                          }
                        }
                      },
                      text: salesAndProfileBtnText,
                      btnColor: AppColorTheme.color().accentColor,
                      hasBorder: false,
                      fontColor: Colors.white,
                      fontSize: fontMedium,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
