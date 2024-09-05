import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view_model/spotify_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SpotifyViewModel spotifyViewModel = SpotifyViewModel();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          homePageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => toUserSearchPage(context: context),
            icon: const Icon(
              Icons.person_search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('ホーム画面です'),
            SizedBox(
              height: 20,
            ),
            Consumer(
              child: const Text('アーティスト検索'),
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () async {
                    spotifyViewModel.setRef(ref);
                    await spotifyViewModel.fetchSpotifyAccessToken();
                    await spotifyViewModel.searchArtists(
                      searchArtistName: '東京事変',
                    );
                  },
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
