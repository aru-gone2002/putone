import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/local_database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/deep_gray_button.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
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

    const double sideProfileWidth = 132;
    const double profileImgSize = 112;

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
                child: Text(failToReadDataErrorText),
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
                    height: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        //左のライン
                        //お気に入り楽曲の表示
                        Align(
                          alignment: const Alignment(-0.95, -0.85),
                          child: Container(
                            height: 48,
                            width: sideProfileWidth,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColorTheme.color().gray2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //TODO アプリを閉じて再度開いた場合、
                                //この時点でUserProfileProviderにローカルのデータが入っている必要がある。
                                //UserProfileProviderには情報が入っていない可能性があるため分岐を行う必要がある。
                                //TODO ログインとかした場合には事前にFirestoreから情報を取得して、
                                //UserProfileProviderにデータが入った状態となっている
                                ExtendedImage.network(
                                  profileViewModel.themeMusicImg == ''
                                      ?
                                      //ローカルDBから画像を取得
                                      (snapshot.data! as List<LocalUserProfile>)
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
                                                    as List<LocalUserProfile>)
                                                .first
                                                .themeMusicName
                                            : profileViewModel.themeMusicName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        profileViewModel.themeMusicArtistName ==
                                                ''
                                            ? (snapshot.data!
                                                    as List<LocalUserProfile>)
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
                        //ユーザー名とユーザーID
                        Align(
                          alignment: const Alignment(-0.95, 0),
                          child: SizedBox(
                            width: sideProfileWidth,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //ユーザー名
                                Text(
                                  profileViewModel.userName == ''
                                      ? (snapshot.data!
                                              as List<LocalUserProfile>)
                                          .first
                                          .userName
                                      : profileViewModel.userName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),

                                //ユーザーID
                                Text(
                                  profileViewModel.userId == ''
                                      ? '@${(snapshot.data! as List<LocalUserProfile>).first.userId}'
                                      : '@${profileViewModel.userId}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //フォローとフォロワー
                        // Align(
                        //   alignment: const Alignment(-0.95, 0.65),
                        //   child: SizedBox(
                        //     width: sideProfileWidth,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Text(
                        //               '24',
                        //               textAlign: TextAlign.center,
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .bodyMedium!
                        //                   .copyWith(
                        //                       fontWeight: FontWeight.bold),
                        //             ),
                        //             const Text(
                        //               'フォロー',
                        //               style: TextStyle(fontSize: 10),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(width: 16),
                        //         Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Text(
                        //               '32',
                        //               textAlign: TextAlign.center,
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .bodyMedium!
                        //                   .copyWith(
                        //                       fontWeight: FontWeight.bold),
                        //             ),
                        //             const Text(
                        //               'フォロワー',
                        //               style: TextStyle(fontSize: 10),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        //所属先
                        Align(
                          alignment: const Alignment(-0.95, 0.65),
                          child: SizedBox(
                            width: sideProfileWidth,
                            child: Text(
                              profileViewModel.communityId == 'none'
                                  ? '所属：${profileViewModel.communityMap[(snapshot.data! as List<LocalUserProfile>).first.communityId]!.communityName}'
                                  : '所属：${profileViewModel.communityMap[profileViewModel.communityId]!.communityName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        //真ん中
                        //ユーザー画像の表示
                        Align(
                          alignment: const Alignment(0, 0),
                          child: ExtendedImage.network(
                            profileViewModel.userImg == ''
                                ? (snapshot.data! as List<LocalUserProfile>)
                                    .first
                                    .userImg
                                : profileViewModel.userImg,
                            width: profileImgSize,
                            height: profileImgSize,
                            fit: BoxFit.cover,
                            cache: true,
                            shape: BoxShape.circle,
                          ),
                        ),
                        //右のライン
                        //ハンバーガーメニュー
                        Align(
                          alignment: const Alignment(0.65, -0.9),
                          child: ElevatedButton.icon(
                            label: const Text('編集'),
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              backgroundColor: AppColorTheme.color().gray2,
                              foregroundColor: Colors.white,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
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
                        Align(
                          alignment: const Alignment(0.95, 0),
                          child: SizedBox(
                            width: sideProfileWidth,
                            child: Text(
                              profileViewModel.userProfileMsg == ''
                                  ? (snapshot.data! as List<LocalUserProfile>)
                                      .first
                                      .userProfileMsg
                                  : profileViewModel.userProfileMsg,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
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
                title: Text(signOutBtnText),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(askwhetherSignOutOrNotDialogTitle),
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
                            Navigator.pop(context);
                            toAuthPage(context: context);
                            await authViewModel.signOut();
                            // await profileViewModel.appDatabase!
                            //     .deleteUserBaseProfile();
                            database.deleteLocalUserProfile();
                          },
                          child: const Text(signOutBtnText),
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
