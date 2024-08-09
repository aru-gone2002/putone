import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/database.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.database});

  final AppDatabase database;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late UserBaseProfile userBaseProfile;

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
    Future(
      () async {
        final userBaseProfiles = await getAllUserBaseProfiles(widget.database);
        userBaseProfile = userBaseProfiles.first;
      },
    );
  }

  //userBaseProfileにローカルDBから取得した情報が入っているため、それをUserProfileProviderに格納する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
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
                          ExtendedImage.network(
                            _profileViewModel.themeMusicImg,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _profileViewModel.themeMusicName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  _profileViewModel.themeMusicArtistName,
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
                        _scaffoldKey.currentState?.openEndDrawer();
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
      ),
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
                        Consumer(
                            child: const Text('ログアウトする'),
                            builder: (context, ref, child) {
                              _authViewModel.setRef(ref);
                              return TextButton(
                                onPressed: () async {
                                  await _authViewModel.signOut();
                                  //TODO Navigator.popをasyncの中で使わない方法を考える
                                  Navigator.pop(context);
                                },
                                child: child!,
                              );
                            }),
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
