// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return _Artist.fromJson(json);
}

/// @nodoc
mixin _$Artist {
  String get artistSpotifyId => throw _privateConstructorUsedError;
  String get artistImg => throw _privateConstructorUsedError;
  String get artistName => throw _privateConstructorUsedError;
  String get spotifyArtistUrl => throw _privateConstructorUsedError;

  /// Serializes this Artist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtistCopyWith<Artist> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistCopyWith<$Res> {
  factory $ArtistCopyWith(Artist value, $Res Function(Artist) then) =
      _$ArtistCopyWithImpl<$Res, Artist>;
  @useResult
  $Res call(
      {String artistSpotifyId,
      String artistImg,
      String artistName,
      String spotifyArtistUrl});
}

/// @nodoc
class _$ArtistCopyWithImpl<$Res, $Val extends Artist>
    implements $ArtistCopyWith<$Res> {
  _$ArtistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artistSpotifyId = null,
    Object? artistImg = null,
    Object? artistName = null,
    Object? spotifyArtistUrl = null,
  }) {
    return _then(_value.copyWith(
      artistSpotifyId: null == artistSpotifyId
          ? _value.artistSpotifyId
          : artistSpotifyId // ignore: cast_nullable_to_non_nullable
              as String,
      artistImg: null == artistImg
          ? _value.artistImg
          : artistImg // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      spotifyArtistUrl: null == spotifyArtistUrl
          ? _value.spotifyArtistUrl
          : spotifyArtistUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtistImplCopyWith<$Res> implements $ArtistCopyWith<$Res> {
  factory _$$ArtistImplCopyWith(
          _$ArtistImpl value, $Res Function(_$ArtistImpl) then) =
      __$$ArtistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String artistSpotifyId,
      String artistImg,
      String artistName,
      String spotifyArtistUrl});
}

/// @nodoc
class __$$ArtistImplCopyWithImpl<$Res>
    extends _$ArtistCopyWithImpl<$Res, _$ArtistImpl>
    implements _$$ArtistImplCopyWith<$Res> {
  __$$ArtistImplCopyWithImpl(
      _$ArtistImpl _value, $Res Function(_$ArtistImpl) _then)
      : super(_value, _then);

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artistSpotifyId = null,
    Object? artistImg = null,
    Object? artistName = null,
    Object? spotifyArtistUrl = null,
  }) {
    return _then(_$ArtistImpl(
      artistSpotifyId: null == artistSpotifyId
          ? _value.artistSpotifyId
          : artistSpotifyId // ignore: cast_nullable_to_non_nullable
              as String,
      artistImg: null == artistImg
          ? _value.artistImg
          : artistImg // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      spotifyArtistUrl: null == spotifyArtistUrl
          ? _value.spotifyArtistUrl
          : spotifyArtistUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtistImpl with DiagnosticableTreeMixin implements _Artist {
  const _$ArtistImpl(
      {required this.artistSpotifyId,
      required this.artistImg,
      required this.artistName,
      required this.spotifyArtistUrl});

  factory _$ArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtistImplFromJson(json);

  @override
  final String artistSpotifyId;
  @override
  final String artistImg;
  @override
  final String artistName;
  @override
  final String spotifyArtistUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Artist(artistSpotifyId: $artistSpotifyId, artistImg: $artistImg, artistName: $artistName, spotifyArtistUrl: $spotifyArtistUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Artist'))
      ..add(DiagnosticsProperty('artistSpotifyId', artistSpotifyId))
      ..add(DiagnosticsProperty('artistImg', artistImg))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('spotifyArtistUrl', spotifyArtistUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistImpl &&
            (identical(other.artistSpotifyId, artistSpotifyId) ||
                other.artistSpotifyId == artistSpotifyId) &&
            (identical(other.artistImg, artistImg) ||
                other.artistImg == artistImg) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.spotifyArtistUrl, spotifyArtistUrl) ||
                other.spotifyArtistUrl == spotifyArtistUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, artistSpotifyId, artistImg, artistName, spotifyArtistUrl);

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      __$$ArtistImplCopyWithImpl<_$ArtistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtistImplToJson(
      this,
    );
  }
}

abstract class _Artist implements Artist {
  const factory _Artist(
      {required final String artistSpotifyId,
      required final String artistImg,
      required final String artistName,
      required final String spotifyArtistUrl}) = _$ArtistImpl;

  factory _Artist.fromJson(Map<String, dynamic> json) = _$ArtistImpl.fromJson;

  @override
  String get artistSpotifyId;
  @override
  String get artistImg;
  @override
  String get artistName;
  @override
  String get spotifyArtistUrl;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}