import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    super.key,
    required this.database,
  });

  final AppDatabase database;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthViewModel authViewModel = AuthViewModel();
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final GlobalObjectKey<ScaffoldState> scaffoldKey = GlobalObjectKey(context);
    authViewModel.setRef(ref);
    profileViewModel.setRef(ref);

    //TODO 問題

    return Scaffold(
      key: scaffoldKey,
      body: StreamBuilder<Object>(
          stream: database.watchAllUserBaseProfiles(),
          //stream: profileViewModel.appDatabase!.watchAllUserBaseProfiles(),
          builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('データの読み込みに失敗しました'),
              );
            }
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          AppColorTheme.color().mainColor,
                        ],
                      ),
                    ),
                    height: 160,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: const Alignment(-0.95, -0.85),
                          child: Container(
                            height: 48,
                            width: 140,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColorTheme.color().gray2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //TODO アプリを閉じて再度開いた場合、
                                //この時点でUserProfileProviderにローカルのデータが入っている必要がある。
                                //TODO ログインとかした場合には事前にFirestoreから情報を取得して、
                                //UserProfileProviderにデータが入った状態となっている
                                ExtendedImage.network(
                                  profileViewModel.themeMusicImg == ''
                                      ?
                                      //ローカルDBから画像を取得
                                      (snapshot.data! as List<UserBaseProfile>)
                                          .first
                                          .themeMusicImg
                                      : profileViewModel.themeMusicImg,
                                  width: 34,
                                  height: 34,
                                  fit: BoxFit.cover,
                                  cache: true,
                                  shape: BoxShape.rectangle,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileViewModel.themeMusicName == ''
                                            ? (snapshot.data!
                                                    as List<UserBaseProfile>)
                                                .first
                                                .themeMusicName
                                            : profileViewModel.themeMusicName,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        //TODO 条件付きでprofileViewModelの中身が''じゃなかったら
                                        profileViewModel.themeMusicArtistName ==
                                                ''
                                            ? (snapshot.data!
                                                    as List<UserBaseProfile>)
                                                .first
                                                .themeMusicArtistName
                                            : profileViewModel
                                                .themeMusicArtistName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.95, -0.9),
                          child: IconButton(
                            icon: const Icon(Icons.dehaze_sharp),
                            onPressed: () {
                              scaffoldKey.currentState?.openEndDrawer();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Center(
                    child: Text('プロフィール画面'),
                  ),
                ],
              ),
            );
          }),
      endDrawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              child: const ListTile(
                title: Text('ログアウトする'),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('ログアウトしますか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(backBtnText),
                        ),
                        TextButton(
                          onPressed: () async {
                            //TODO ローカルDBを削除する
                            //引数のUserBaseProfileはUserBaseProfilesの中身の1つであるから、
                            //getAllUserBaseProfilesメソッドで取得して、.firstメソッドで入れる
                            //or Streamでやる
                            //or 最初に取ってきたデータベースを捨てるか

                            Navigator.pop(context);
                            await authViewModel.signOut();
                            // await profileViewModel.appDatabase!
                            //     .deleteUserBaseProfile();
                            database.deleteUserBaseProfile();
                          },
                          child: const Text('ログアウトする'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
