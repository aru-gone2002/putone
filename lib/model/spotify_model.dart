import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';

class SpotifyModel {
  Future<String?> fetchAccessToken() async {
    const host = 'accounts.spotify.com';
    const tokenEndPoint = '/api/token';
    final String clientId = dotenv.get('SPOTIFY_API_CLIENT_ID');
    final String clientSecret = dotenv.get('SPOTIFY_CLIENT_SEACRET');
    final Map<String, String> requestBody = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    final url = Uri.https(host, tokenEndPoint);
    print('url: $url');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    try {
      final response =
          await http.post(url, body: requestBody, headers: headers);
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      return accessToken;
    } catch (e) {
      //TODO 処理を入れる
      print(e.toString());
      return null;
    }
  }

  Future<List<SpotifyTrack>> searchTracks({
    required String accessToken,
    required String searchTrackName,
    required String searchArtistName,
  }) async {
    const String searchEndPoint = 'https://api.spotify.com/v1/search';
    const String searchType = 'type=track';
    const String limit = 'limit=30';
    String trackFilter = '';
    String artistFilter = '';
    String query = '';

    //返す楽曲のリスト
    List<SpotifyTrack> searchResponseTrackList = [];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    //検索の際に曲名が書かれているかでクエリの中身を変更
    //日本語でもqueryを反応できるようにencodeQueryComponentを行う
    if (searchTrackName != '') {
      String trackEncodedQuery = Uri.encodeQueryComponent(searchTrackName);
      trackFilter = 'track%3A$trackEncodedQuery';
      //trackFilter = 'track%3A$searchTrackName';
    }

    //検索の際にアーティスト名が書かれているかでクエリの中身を変更
    //日本語でもqueryを反応できるようにencodeQueryComponentを行う
    if (searchArtistName != '') {
      String artistEncodedQuery = Uri.encodeQueryComponent(searchArtistName);
      artistFilter = 'artist%3A$artistEncodedQuery';
      //artistFilter = 'artist%3A$seachArtistName';
    }

    //書き込まれているかでクエリを分岐
    if (searchArtistName == '' && searchTrackName != '') {
      query = 'q=$trackFilter';
    } else if (searchArtistName != '' && searchTrackName == '') {
      query = 'q=$artistFilter';
    } else if (searchArtistName != '' && searchTrackName != '') {
      query = 'q=$trackFilter&$artistFilter';
    }

    //リクエストのURL
    final String endPointUrl = '$searchEndPoint?$query&$searchType&$limit';

    //http.getで楽曲を検索
    final response = await http.get(
      Uri.parse(endPointUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> trackData = jsonDecode(response.body);
      final List<dynamic> tracks = trackData['tracks']['items'];

      for (int i = 0; i < tracks.length; i++) {
        final String trackImg = tracks[i]['album']['images'][1]['url'];
        final String artistName = tracks[i]['artists'][0]['name'];
        final String trackName = tracks[i]['name'];
        final String trackExternalUrl = tracks[i]['external_urls']['spotify'];
        final String? previewUrl = tracks[i]['preview_url'];
        final SpotifyTrack spotifyTrack = SpotifyTrack(
          trackImg: trackImg,
          artistName: artistName,
          trackName: trackName,
          trackExternalUrl: trackExternalUrl,
          previewUrl: previewUrl ?? '',
        );
        searchResponseTrackList.add(spotifyTrack);
      }

      return searchResponseTrackList;
    } else {
      print('Spotify API Error: ${response.statusCode}');
      return searchResponseTrackList;
    }
  }

  Future<void> _getArtist(String? accessToken) async {
    // Replace with your actual access token

    // Set the base URL for Spotify API
    const String baseUrl = 'https://api.spotify.com/v1';

    // Specify the artist ID
    const String artistId = '4QvgGvpgzgyUOo8Yp8LDm9?si=uhLfYaonSl6wOe9rM6Gmuw';

    // Construct the full API endpoint URL
    const String endpointUrl = '$baseUrl/artists/$artistId';

    // Create the HTTP request headers
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // Send the GET request to the Spotify API
    final response = await http.get(
      Uri.parse(endpointUrl),
      headers: headers,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> artistData = jsonDecode(response.body);

      // Print the artist's name
      print('Artist Name: ${artistData['name']}');
      print(artistData);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<List<Artist>?> searchArtists({
    required String accessToken,
    required String searchArtistName,
  }) async {
    const String searchEndPoint = 'https://api.spotify.com/v1/search';
    const String searchType = 'type=artist';
    const String limit = 'limit=30';
    String query = '';

    //返すアーティストのリスト
    List<Artist> searchResponseArtistList = [];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    query = 'q=$searchArtistName';

    //final String endPointUrl = '$searchEndPoint?$query&$searchType&$limit';
    final String endPointUrl = '$searchEndPoint?$query&$searchType&$limit';
    Uri uri = Uri.parse(endPointUrl);

    //http.getで楽曲を検索
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistData = jsonDecode(response.body);
      final List<dynamic> artists = artistData['artists']['items'];

      for (int i = 0; i < artists.length; i++) {
        final String artistImg = artists[i]['images'][2]['url'];
        final String artistName = artists[i]['name'];
        final String artistSpotifyId = artists[i]['id'];
        final String spotifyArtistUrl = artists[i]['external_urls']['spotify'];
        final Artist artist = Artist(
          artistImg: artistImg,
          artistName: artistName,
          artistSpotifyId: artistSpotifyId,
          spotifyArtistUrl: spotifyArtistUrl,
        );
        searchResponseArtistList.add(artist);
        print(artist);
      }

      return searchResponseArtistList;
    } else {
      print('Spotify API Error: ${response.statusCode}');
      return null;
    }
  }
}
