import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ThemeSongSettingPage extends ConsumerStatefulWidget {
  const ThemeSongSettingPage({super.key});
  @override
  ConsumerState<ThemeSongSettingPage> createState() {
    return _ThemeSongSettingPageState();
  }
}

class _ThemeSongSettingPageState extends ConsumerState<ThemeSongSettingPage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final TextEditingController _trackNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileViewModel.setRef(ref);
  }

  @override
  void dispose() {
    super.dispose();
    _trackNameController.dispose();
    _artistNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          themeSongSettingPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spaceWidthMedium, vertical: spaceHeightSmall),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              selectedThemeSongLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              _profileViewModel.themeMusicName != ''
                  ? '${_profileViewModel.themeMusicName} / ${_profileViewModel.themeMusicArtistName}'
                  : askToSelectMusicText,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColorTheme.color().gray1,
                  ),
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(musicNameLabel),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  decoration: BoxDecoration(
                      color: AppColorTheme.color().gray3,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            offset: Offset(2, 4),
                            color: Color.fromARGB(50, 0, 0, 0)),
                      ]),
                  child: TextField(
                    controller: _trackNameController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _trackNameController.clear();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(artistNameLabel),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  decoration: BoxDecoration(
                      color: AppColorTheme.color().gray3,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            offset: Offset(2, 4),
                            color: Color.fromARGB(50, 0, 0, 0)),
                      ]),
                  child: TextField(
                    controller: _artistNameController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _artistNameController.clear();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 108,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorTheme.color().gray1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      //onPressed
                      onPressed: () {
                        if (_artistNameController.text == '' &&
                            _trackNameController.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text(askToEnterTrackOrArtistSnackBarText),
                            ),
                          );
                        } else {
                          _profileViewModel.searchTracks(
                            searchTrackName: _trackNameController.text,
                            searchArtistName: _artistNameController.text,
                          );
                        }
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            searchBtnText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
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
              child: _profileViewModel.spotifySearchTracks.isEmpty
                  ? const Center(
                      child: Text(askToSearchByTrackAndArtistText),
                    )
                  : ListView.builder(
                      itemCount: _profileViewModel.spotifySearchTracks.length,
                      itemBuilder: (context, index) {
                        final spotifySearchTrack =
                            _profileViewModel.spotifySearchTracks[index];
                        return ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text(musicSettingConfirmDialogText),
                                  content: Text(
                                      '${spotifySearchTrack.trackName} / ${spotifySearchTrack.artistName}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(backBtnText),
                                    ),
                                    TextButton(
                                        child: const Text(registerBtnText),
                                        onPressed: () {
                                          _profileViewModel.setThemeSong(
                                              track: spotifySearchTrack);
                                          //ダイアログを閉じる
                                          Navigator.pop(context);
                                          //テーマソングの登録画面を閉じる
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              },
                            );
                          },
                          leading: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                //Spotify APIのSearchで取得してきた楽曲の画像を入れる。
                                image:
                                    NetworkImage(spotifySearchTrack.trackImg),
                              ),
                            ),
                          ),
                          //Spotify APIのSearchで取得してきた楽曲の名前を入れる。
                          title: Text(spotifySearchTrack.trackName),
                          //Spotify APIのSearchで取得してきたアーティストの名前を入れる。
                          subtitle: Text(spotifySearchTrack.artistName),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 48),
            //TODO アクセストークンを取得するためのボタン、リリース段階では削除する
            DeepGrayButton(
              onPressed: () async {
                await _profileViewModel.fetchSpotifyAccessToken();
              },
              text: 'アクセストークン取得',
            ),
          ]),
        ),
      ),
    );
  }
}
