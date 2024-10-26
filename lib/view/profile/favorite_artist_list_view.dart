import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';

class FavoriteArtistListView extends ConsumerWidget {
  const FavoriteArtistListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
    artistFollowViewModel.setRef(ref);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: spaceWidthMedium, vertical: paddingHeightSmall),
      itemCount: artistFollowViewModel.favoriteArtists.length,
      itemBuilder: (context, index) {
        final Artist artist = artistFollowViewModel.favoriteArtists[index];
        return ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: ExtendedImage.network(
            artist.artistImg,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            cache: true,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),
          //Spotify APIのSearchで取得してきたアーティスト名を入れる。
          title: Text(
            artist.artistName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // trailing:
          //     ArtistFollowButton(key: UniqueKey(), favoriteArtist: artist),
        );
      },
    );
  }
}
