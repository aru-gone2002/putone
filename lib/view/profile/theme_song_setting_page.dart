import 'package:flutter/cupertino.dart';
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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileViewModel.setRef(ref);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spaceWidthMedium),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: spaceHeightMedium,
          ),
          Text(
            '選択したテーマソング',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            _profileViewModel.themeMusicName != ''
                ? '${_profileViewModel.themeMusicName} / ${_profileViewModel.themeMusicArtistName}'
                : '以下の楽曲から選択してください',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColorTheme.color().gray1,
                ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            decoration: BoxDecoration(
                color: AppColorTheme.color().gray3,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(2, 4),
                      color: Color.fromARGB(50, 0, 0, 0)),
                ]),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.cancel_outlined),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
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
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            //Spotify APIのSearchで取得してきた楽曲の画像を入れる。
                            //image: NetworkImage(),
                            image: AssetImage('assets/images/idol.png')),
                      ),
                    ),
                    //Spotify APIのSearchで取得してきた楽曲の名前を入れる。
                    title: Text('アイドル'),
                    //Spotify APIのSearchで取得してきたアーティストの名前を入れる。
                    subtitle: Text('YOASOBI'),
                  );
                }),
          ),
          const SizedBox(height: 48),
          DeepGrayButton(onPressed: () {}, text: registerBtnText),
        ]),
      ),
    );
  }
}
