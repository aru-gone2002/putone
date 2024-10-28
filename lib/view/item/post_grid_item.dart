import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/local_database.dart';

class PostGridItem extends StatelessWidget {
  const PostGridItem({
    super.key,
    required this.onTap,
    this.userPost,
    this.localUserPost,
  });

  final Post? userPost;
  final LocalUserPost? localUserPost;
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: const Alignment(0, 0),
              child: ExtendedImage.network(
                (userPost == null)
                    ? localUserPost!.postMusicImg
                    : userPost!.postMusicImg,
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
                  const Icon(
                    Icons.music_note_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: postGridItemWidth * 0.65,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (userPost == null)
                              ? localUserPost!.postMusicName
                              : userPost!.postMusicName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          (userPost == null)
                              ? localUserPost!.postMusicArtistName
                              : userPost!.postMusicArtistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //TODO ボタンが押されたら赤くする
            Align(
              alignment: const Alignment(1.05, 0.95),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
