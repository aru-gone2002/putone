import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/artist_follow_view_model.dart';
import 'package:putone/view_model/follow_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';

class ArtistFollowButton extends ConsumerStatefulWidget {
  const ArtistFollowButton({
    super.key,
    //TODO followingArtistに変換
    // required this.followingUser,
    required this.favoriteArtist,
  });

  //TODO followingArtistに変換
  //final FollowingUser followingUser;
  final Artist favoriteArtist;

  @override
  ConsumerState<ArtistFollowButton> createState() {
    return _ArtistFollowButtonState();
  }
}

class _ArtistFollowButtonState extends ConsumerState<ArtistFollowButton> {
  late bool isFollowing;
  final FollowViewModel followViewModel = FollowViewModel();
  final ArtistFollowViewModel artistFollowViewModel = ArtistFollowViewModel();
  final LocalDatabaseViewModel localDatabaseViewModel =
      LocalDatabaseViewModel();

  @override
  void initState() {
    super.initState();
    //TODO 変更
    //followViewModel.setRef(ref);
    artistFollowViewModel.setRef(ref);
    localDatabaseViewModel.setRef(ref);
    //ここでフォローしているかしていないかを調べている
    //変更
    isFollowing = artistFollowViewModel.favoriteArtists
        .where(
          (followingArtist) =>
              widget.favoriteArtist.artistSpotifyId ==
              followingArtist.artistSpotifyId,
        )
        .toList()
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // final followingUser = widget.followingUser;
    final favoriteArtist = widget.favoriteArtist;

    return ElevatedButton(
      onPressed: () async {
        //TODO 新しくフォローする時の処理
        if (isFollowing == false) {
          //TODO
          // providerにフォローしたアーティストを新たに加える
          // Firestoreにフォローするアーティストのドキュメントを追加する
          await artistFollowViewModel.followArtist(
              favoriteArtist: favoriteArtist);
          // ローカルDBにフォローするアーティストのドキュメントを追加する
          await localDatabaseViewModel.appDatabase!
              .insertLocalUserFavoriteArtist(favoriteArtist);
          setState(() {
            isFollowing = artistFollowViewModel.favoriteArtists
                .where(
                  (followingArtist) =>
                      widget.favoriteArtist.artistSpotifyId ==
                      followingArtist.artistSpotifyId,
                )
                .toList()
                .isNotEmpty;
          });
        } else {
          //TODO 既にフォローしていたときの処理
          // providerからアンフォローするアーティストを削除する
          // Firestoreからアンフォローするアーティストのドキュメントを削除する
          await artistFollowViewModel.unfollowArtist(
              favoriteArtistId: favoriteArtist.artistSpotifyId);
          // ローカルDBにフォローするアーティストのドキュメントを追加する
          await localDatabaseViewModel.appDatabase!
              .deleteSpecificLocalUserFavoriteArtist(favoriteArtist);
          setState(() {
            isFollowing = artistFollowViewModel.favoriteArtists
                .where(
                  (followingArtist) =>
                      widget.favoriteArtist.artistSpotifyId ==
                      followingArtist.artistSpotifyId,
                )
                .toList()
                .isNotEmpty;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 6),
        backgroundColor: (!isFollowing)
            ? AppColorTheme.color().accentColor
            : AppColorTheme.color().gray1,
        foregroundColor: Colors.white,
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
      ),
      child: Text((!isFollowing) ? followBtnText : followingBtnText),
    );
  }
}
