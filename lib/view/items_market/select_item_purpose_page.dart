import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:putone/constants/doubles.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/view/item/button/circular_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SelectItemPurposePage extends HookConsumerWidget {
  const SelectItemPurposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel profileViewModel = ProfileViewModel();
    profileViewModel.setRef(ref);

    final item = useState(
      Item(
        uid: profileViewModel.uid,
        itemId: '',
        isForSale: false,
        artistSpotifyId: '',
        artistName: '',
        artistSpotifyUrl: '',
        itemImgs: ['', '', '', ''],
        itemName: '',
        itemDescription: '',
        price: 0,
        size: '',
        categories: [],
        createdAt: DateTime.now(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          itemPageAppbarTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spaceHeightMedium),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                askToRegisterItemPurposeText,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              CircularButton(
                onPressed: () {
                  item.value = item.value.copyWith(isForSale: false);
                  toSelectArtistForItemPage(context: context, item: item);
                },
                text: onlyForProfileBtnText,
                btnColor: Colors.white,
                hasBorder: true,
                fontColor: Colors.black,
                fontSize: fontMedium,
              ),
              const SizedBox(height: 12),
              CircularButton(
                onPressed: () {
                  item.value = item.value.copyWith(isForSale: true);
                  toSelectArtistForItemPage(context: context, item: item);
                },
                text: salesAndProfileBtnText,
                btnColor: Colors.white,
                hasBorder: true,
                fontColor: Colors.black,
                fontSize: fontMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
