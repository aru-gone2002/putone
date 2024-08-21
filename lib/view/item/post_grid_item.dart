import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';

class PostGridItem extends StatelessWidget {
  const PostGridItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //投稿のGridViewの横の長さを計算
    final double postGridItemWidth =
        (size.width - postGridViewCrossAxisSpacing - spaceWidthMedium * 2) / 2;

    return Container(
      width: postGridItemWidth,
      height: postGridItemWidth + postGridItemTitleSpaceHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(2, 4),
            color: Color.fromARGB(35, 0, 0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
              height: postGridItemWidth,
              width: postGridItemWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.7, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                  image: ExtendedImage.network(
                    post.postMusicImg,
                    width: postGridItemWidth,
                    height: postGridItemWidth,
                    fit: BoxFit.cover,
                    cache: true,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ) as ImageProvider,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: const Alignment(-0.95, 0.75),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.music_note_outlined),
                        const SizedBox(width: 2),
                        SizedBox(
                          width: postGridItemWidth * 0.75,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                post.postMusicName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                post.postMusicArtistName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO ボタンが押されたら赤くする
                  Align(
                    alignment: const Alignment(0.95, 0.85),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: postGridItemTitlePaddingWidth,
                vertical: postGridItemTitlePaddingHeight,
              ),
              child: Text(
                post.postMsg,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
