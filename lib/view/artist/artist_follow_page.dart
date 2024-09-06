import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: spaceWidthMedium,
            vertical: spaceHeightSmall,
          ),
          child: Column(
            children: [
              //TODO アーティスト名入力フォーム
              Container(
                padding: const EdgeInsets.only(left: 16, right: 4),
                decoration: BoxDecoration(
                  color: AppColorTheme.color().gray3,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(2, 4),
                      color: Color.fromARGB(50, 0, 0, 0),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _artistNameController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        //TODO アーティストで検索するようにする
                        await _spotifyViewModel.fetchSpotifyAccessToken();
                        await _spotifyViewModel.searchArtists(
                            searchArtistName: _artistNameController.text);
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              //楽曲表示スペース
              Container(
                height: 300,
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
                //楽曲の表示
                //TODO この中身のproviderViewModelはspotifyViewModelに移行する
                child: _spotifyViewModel.spotifySearchTracks.isEmpty
                    ? const Center(
                        //TODO textの中身を変更する
                        child: Text(askToSearchByTrackAndArtistText),
                      )
                    : ListView.builder(
                        //TODO このitemの中身を変更する
                        itemCount: _spotifyViewModel.spotifySearchTracks.length,
                        itemBuilder: (context, index) {
                          final spotifySearchTrack =
                              _spotifyViewModel.spotifySearchTracks[index];
                          //楽曲一つ一つの表示ListTile
                          return ListTile(
                            onTap: () {},
                            leading: ExtendedImage.network(
                              spotifySearchTrack.trackImg,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              cache: true,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            //Spotify APIのSearchで取得してきた楽曲の名前を入れる。
                            title: Text(spotifySearchTrack.trackName),
                            //Spotify APIのSearchで取得してきたアーティストの名前を入れる。
                            subtitle: Text(spotifySearchTrack.artistName),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
