import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view_model/profile_view_model.dart';
import 'package:extended_image/extended_image.dart';

class FriendProfilePage extends ConsumerStatefulWidget {
  const FriendProfilePage({super.key, required this.uid});

  final String uid;

  @override
  ConsumerState<FriendProfilePage> createState() {
    return FriendProfilePageState();
  }
}

class FriendProfilePageState extends ConsumerState<FriendProfilePage> {
  @override
  void initState() {
    super.initState();
    ref.read(userProfileProvider);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final GlobalObjectKey<ScaffoldState> scaffoldKey = GlobalObjectKey(context);
    profileViewModel.setRef(ref);

    const double sideProfileWidth = 132;
    const double profileImgSize = 112;

    // Firestoreからプロフィール情報を取得する
    //print(widget.uid);
    profileViewModel.getUserProfile(widget.uid);
    //print(profileViewModel.userId);

    return Scaffold(
      key: scaffoldKey,
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
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: const Alignment(-0.95, -0.85),
                    child: Container(
                      height: 48,
                      width: sideProfileWidth,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColorTheme.color().gray2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ExtendedImage.network(
                            profileViewModel.themeMusicImg,
                            height: favoriteMusicImgHeight,
                            width: favoriteMusicImgWidth,
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
                                  profileViewModel.themeMusicName,
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
                                  profileViewModel.themeMusicArtistName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.95, 0),
                    child: SizedBox(
                      width: sideProfileWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            profileViewModel.userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '@${profileViewModel.userId}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.95, 0.65),
                    child: SizedBox(
                      width: sideProfileWidth,
                      child: Text(
                        '所属：${profileViewModel.communityMap[profileViewModel.communityId]!.communityName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0),
                    child: ExtendedImage.network(
                      profileViewModel.userImg,
                      width: profileImgSize,
                      height: profileImgSize,
                      fit: BoxFit.cover,
                      cache: true,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorTheme.color().mainColor,
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
                        profileViewModel.userProfileMsg,
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
          ],
        ),
      ),
    );
  }
}
