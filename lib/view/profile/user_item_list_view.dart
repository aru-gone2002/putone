import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/view/item/item_grid_piece.dart';
import 'package:putone/view_model/item_view_model.dart';

class UserItemListView extends ConsumerWidget {
  const UserItemListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemViewModel itemViewModel = ItemViewModel();
    itemViewModel.setRef(ref);

    //投稿のGridViewの横の長さを計算
    var size = MediaQuery.of(context).size;
    //投稿のGridViewの横の長さを計算
    final double postGridItemWidth =
        (size.width - postGridViewCrossAxisSpacing - postGridPaddingWidth * 2) /
            2;

    return itemViewModel.userItems.isEmpty
        ? const Center(
            child: Text(askToRegisterArtistItemsText),
          )
        : GridView.builder(
            padding: const EdgeInsets.only(
              left: postGridPaddingWidth,
              right: postGridPaddingWidth,
              top: postGridPaddingHeight,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: postGridViewCrossAxisSpacing,
              mainAxisSpacing: postGridViewMainAxisSpacing,
              childAspectRatio: postGridItemWidth / (postGridItemWidth + 52),
            ),
            itemCount: itemViewModel.userItems.length,
            itemBuilder: (context, index) {
              return ItemGridPiece(
                //userPost: postViewModel.posts[index],
                // onTap: () => onPostTap(localUserPost),
                userItem: itemViewModel.userItems[index],
                onTap: () {},
              );
            });
  }
}
