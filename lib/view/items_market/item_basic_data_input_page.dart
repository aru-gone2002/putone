import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:putone/constants/doubles.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/item_view_model.dart';

class ItemBasicDataInputPage extends ConsumerWidget {
  const ItemBasicDataInputPage({super.key, required this.item});

  final ValueNotifier<Item> item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemViewModel itemViewModel = ItemViewModel();

    Future<void> onImageTapped({required int index}) async {
      final imgResult = await itemViewModel.onImageTapped();
      if (imgResult != null) {
        //TODO 本当はここでStorageに写真を入れず、最後に確定したタイミングで入れるようにしたい。
        await itemViewModel.deletePhotoData(item.value.itemImgs[index]);
        item.value.itemImgs.remove(index);
        item.value.itemImgs.insert(index, imgResult);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: spaceHeightMedium,
          right: spaceWidthMedium,
          top: spaceHeightSmall,
        ),
        child: SingleChildScrollView(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
