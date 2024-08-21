import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view_model/profile_view_model.dart';

class PostCreatePage extends ConsumerStatefulWidget {
  const PostCreatePage({super.key});
  @override
  ConsumerState<PostCreatePage> createState() {
    return _PostCreatePageState();
  }
}

class _PostCreatePageState extends ConsumerState<PostCreatePage> {
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
          postCreatePageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spaceWidthMedium,
            vertical: spaceHeightSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectSongLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(musicNameLabel),
                  //楽曲名入力フォーム
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
                  //アーティスト名入力フォーム
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
                  //検索ボタン
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
                            Fluttertoast.showToast(
                                msg: askToEnterTrackOrArtistToastText);
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
                child: _profileViewModel.spotifySearchTracks.isEmpty
                    ? const Center(
                        child: Text(askToSearchByTrackAndArtistText),
                      )
                    : ListView.builder(
                        itemCount: _profileViewModel.spotifySearchTracks.length,
                        itemBuilder: (context, index) {
                          final spotifySearchTrack =
                              _profileViewModel.spotifySearchTracks[index];
                          //楽曲一つ一つの表示ListTile
                          return ListTile(
                            //TODO ここの機能を変更する
                            //タップしたら、タップした楽曲の情報が次の投稿メッセージ作成画面に行くように変更したい
                            onTap: () async {
                              toPostAddMsgPage(
                                  context: context,
                                  selectedTrack: spotifySearchTrack);
                            },
                            //ジャケ写
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
              // const SizedBox(height: 48),
              // //TODO アクセストークンを取得するためのボタン、リリース段階では削除する
              // DeepGrayButton(
              //   onPressed: () async {
              //     await _profileViewModel.fetchSpotifyAccessToken();
              //   },
              //   text: 'アクセストークン取得',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
