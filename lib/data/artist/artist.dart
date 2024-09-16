// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'artist.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'artist.g.dart';

@freezed
class Artist with _$Artist {
  const factory Artist({
    required String artistSpotifyId,
    required String artistImg,
    required String artistName,
    required String spotifyArtistUrl,
  }) = _Artist;

  factory Artist.fromJson(Map<String, Object?> json) => _$ArtistFromJson(json);
}