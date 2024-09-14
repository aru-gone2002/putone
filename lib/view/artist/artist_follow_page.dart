import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/artist_follow_buton.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class ArtistFollowPage extends ConsumerStatefulWidget {
  const ArtistFollowPage({
    super.key,
  });

  @override
  ConsumerState<ArtistFollowPage> createState() {
    return _ThemeSongSettingPageState();
  }
}

class _ThemeSongSettingPageState extends ConsumerState<ArtistFollowPage> {
  final SpotifyViewModel _spotifyViewModel = SpotifyViewModel();
  final TextEditingController _artistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _spotifyViewModel.setRef(ref);
  }

  @override
  void dispose() {
    super.dispose();
    _artistNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          artistFollowPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //アーティスト名入力フォーム
            Container(
              color: AppColorTheme.color().mainColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    spaceWidthMedium, 8, spaceWidthMedium, 16),
                child: TextField(
                  controller: _artistNameController,
                  onSubmitted: (value) async {
                    //アーティストで検索するようにする
                    final result = await _spotifyViewModel.searchArtists(
                        searchArtistName: value);
                    if (result is List<Artist>) {
                      _spotifyViewModel.saveSpotifySearchArtists(result);
                    } else {
                      Fluttertoast.showToast(msg: failToGetArtistInfoToastText);
                    }
                  },
                  cursorColor: AppColorTheme.color().mainColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: writeArtistNameHintText,
                    hintStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: AppColorTheme.color().gray1,
                            ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        //アーティストで検索するようにする
                        final result = await _spotifyViewModel.searchArtists(
                            searchArtistName: _artistNameController.text);
                        if (result is List<Artist>) {
                          _spotifyViewModel.saveSpotifySearchArtists(result);
                        } else {
                          Fluttertoast.showToast(
                              msg: failToGetArtistInfoToastText);
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: AppColorTheme.color().mainColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: AppColorTheme.color().mainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: spaceWidthMedium,
                vertical: spaceHeightSmall,
              ),
              child: Column(
                children: [
                  //アーティスト表示スペース
                  Container(
                    height: 480,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 4,
                              offset: Offset(2, 4),
                              spreadRadius: 2,
                              color: Color.fromARGB(60, 0, 0, 0)),
                        ]),
                    //アーティストの表示
                    //この中身のproviderViewModelはspotifyViewModelに移行する
                    child: _spotifyViewModel.spotifySearchArtists.isEmpty
                        ? const Center(
                            //TODO textの中身を変更する
                            child: Text(askToSearchByArtistText),
                          )
                        : ListView.builder(
                            //TODO このitemの中身を変更する
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            itemCount:
                                _spotifyViewModel.spotifySearchArtists.length,
                            itemBuilder: (context, index) {
                              final spotifySearchArtist =
                                  _spotifyViewModel.spotifySearchArtists[index];
                              //アーティスト一つ一つの表示ListTile
                              return ListTile(
                                onTap: () {},
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 4),
                                leading: ExtendedImage.network(
                                  spotifySearchArtist.artistImg,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  cache: true,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                //Spotify APIのSearchで取得してきたアーティスト名を入れる。
                                title: Text(
                                  spotifySearchArtist.artistName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: ArtistFollowButton(
                                    favoriteArtist: spotifySearchArtist),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
