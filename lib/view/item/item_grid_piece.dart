import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/local_database.dart';

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
      child: Container(
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
        child: SizedBox(
          width: postGridItemWidth,
          height: postGridItemWidth,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: const Alignment(0, 0),
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
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  width: postGridItemWidth,
                  height: postGridItemWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.1, 0.6, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-0.95, 0.85),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Icon(
                    //   Icons.music_note_outlined,
                    //   color: Colors.white,
                    // ),
                    // const SizedBox(width: 4),
                    SizedBox(
                      width: postGridItemWidth * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userItem.itemName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              userItem.artistName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO ボタンが押されたら赤くする
              // Align(
              //   alignment: const Alignment(1.05, 0.95),
              //   child: IconButton(
              //     padding: EdgeInsets.zero,
              //     constraints: const BoxConstraints(),
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.favorite_border_outlined,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
