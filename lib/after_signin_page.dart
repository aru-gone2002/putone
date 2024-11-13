import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/artist/artist_follow_page.dart';
import 'package:putone/view/home/home_page.dart';
import 'package:putone/view/profile/profile_page.dart';
import 'package:putone/view/profile_card/profile_card.dart';
import 'package:putone/view_model/bottom_navigation_bar_view_model.dart';

class AfterSignInPage extends ConsumerWidget {
  const AfterSignInPage({
    super.key,
    // required this.database,
  });

  // final AppDatabase database;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BottomNavigationBarViewModel bottomNavigationBarViewModel =
        BottomNavigationBarViewModel();
    bottomNavigationBarViewModel.setRef(ref);

    const List<Widget> bottomNavigationWidgets = [
      HomePage(),
      ArtistFollowPage(),
      ProfilePage(),
      ProfileCardPage(),
    ];

    return Scaffold(
      body: bottomNavigationWidgets[
          bottomNavigationBarViewModel.bottomNavigationBarCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColorTheme.color().mainColor,
        currentIndex:
            bottomNavigationBarViewModel.bottomNavigationBarCurrentIndex,
        onTap: (index) => bottomNavigationBarViewModel
            .saveBottomNavigationBarCurrentIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          // //BottomNavigationBarItem(icon: Icon(Icons.hail), label: 'myquiz'),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.guitar), label: 'artist'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.style,
            ),
            label: 'profilecard',
          ),
        ],
      ),
    );
  }
}
