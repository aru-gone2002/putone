import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class SelectArtistForItemPage extends ConsumerStatefulWidget {
  const SelectArtistForItemPage({super.key, required this.item});

  final ValueNotifier<Item> item;

  @override
  ConsumerState<SelectArtistForItemPage> createState() {
    return _SelectArtistForItemPageState();
  }
}

class _SelectArtistForItemPageState
    extends ConsumerState<SelectArtistForItemPage> {
  final SpotifyViewModel _spotifyViewModel = SpotifyViewModel();
  final TextEditingController _artistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _spotifyViewModel.setRef(ref);
    print('isForSale: ${widget.item.value.isForSale.toString()}');
  }

  @override
  void dispose() {
    super.dispose();
    _artistNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          itemPageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            right: spaceWidthMedium,
            left: spaceWidthMedium,
            top: spaceWidthMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selectItemArtistLabel,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.left),
            const SizedBox(height: 16),
            //アーティスト名入力フォーム
            TextField(
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
                  horizontal: 24,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: writeArtistNameHintText,
                hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColorTheme.color().gray1,
                      fontWeight: FontWeight.normal,
                    ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    //アーティストで検索するようにする
                    final result = await _spotifyViewModel.searchArtists(
                        searchArtistName: _artistNameController.text);
                    if (result is List<Artist>) {
                      _spotifyViewModel.saveSpotifySearchArtists(result);
                    } else {
                      Fluttertoast.showToast(msg: failToGetArtistInfoToastText);
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            //アーティスト表示スペース
            Column(
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
                          child: Text(askToSearchByArtistText),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount:
                              _spotifyViewModel.spotifySearchArtists.length,
                          itemBuilder: (context, index) {
                            final spotifySearchArtist =
                                _spotifyViewModel.spotifySearchArtists[index];
                            //アーティスト一つ一つの表示ListTile
                            return ListTile(
                              onTap: () {
                                widget.item.value = widget.item.value.copyWith(
                                  artistName: spotifySearchArtist.artistName,
                                  artistSpotifyId:
                                      spotifySearchArtist.artistSpotifyId,
                                  artistSpotifyUrl:
                                      spotifySearchArtist.spotifyArtistUrl,
                                );
                                //TODO ここにアイテム登録画面に遷移する処理を書く
                                toItemBasicDataInputPagePage(
                                    context: context, item: widget.item);
                              },
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
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
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
