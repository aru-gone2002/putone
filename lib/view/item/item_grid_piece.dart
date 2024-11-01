import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/local_database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/items_market/detail_item_screen.dart';

class ItemGridPiece extends StatelessWidget {
  const ItemGridPiece({
    super.key,
    required this.onTap,
    required this.userItem,
    // this.localUserPost,
  });

  final Item userItem;
  // final LocalUserPost? localUserPost;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    //投稿のGridViewの横の長さを計算
    var size = MediaQuery.of(context).size;
    //投稿のGridViewの横の長さを計算
    final double postGridItemWidth =
        (size.width - postGridViewCrossAxisSpacing - postGridPaddingWidth * 2) /
            2;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: postGridItemWidth,
            //height: postGridItemWidth + postGridItemTitleSpaceHeight,
            height: postGridItemWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(2, 4),
                  color: Color.fromARGB(50, 0, 0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailItemScreen(userItem: userItem);
                }));
              },
              child: Hero(
                tag: userItem.itemId,
                child: ExtendedImage.network(
                  userItem.itemImgs[0],
                  width: postGridItemWidth,
                  height: postGridItemWidth,
                  fit: BoxFit.cover,
                  cache: true,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              userItem.itemName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          // const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              userItem.artistName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColorTheme.color().gray1),
            ),
          ),
        ],
      ),
    );
  }
}
