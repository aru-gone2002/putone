// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $LocalUserProfilesTable extends LocalUserProfiles
    with TableInfo<$LocalUserProfilesTable, LocalUserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userImgMeta =
      const VerificationMeta('userImg');
  @override
  late final GeneratedColumn<String> userImg = GeneratedColumn<String>(
      'user_img', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _themeMusicImgMeta =
      const VerificationMeta('themeMusicImg');
  @override
  late final GeneratedColumn<String> themeMusicImg = GeneratedColumn<String>(
      'theme_music_img', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _themeMusicNameMeta =
      const VerificationMeta('themeMusicName');
  @override
  late final GeneratedColumn<String> themeMusicName = GeneratedColumn<String>(
      'theme_music_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _themeMusicArtistNameMeta =
      const VerificationMeta('themeMusicArtistName');
  @override
  late final GeneratedColumn<String> themeMusicArtistName =
      GeneratedColumn<String>('theme_music_artist_name', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _themeMusicSpotifyUrlMeta =
      const VerificationMeta('themeMusicSpotifyUrl');
  @override
  late final GeneratedColumn<String> themeMusicSpotifyUrl =
      GeneratedColumn<String>('theme_music_spotify_url', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _themeMusicPreviewUrlMeta =
      const VerificationMeta('themeMusicPreviewUrl');
  @override
  late final GeneratedColumn<String> themeMusicPreviewUrl =
      GeneratedColumn<String>('theme_music_preview_url', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _userProfileMsgMeta =
      const VerificationMeta('userProfileMsg');
  @override
  late final GeneratedColumn<String> userProfileMsg = GeneratedColumn<String>(
      'user_profile_msg', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 120),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _userSpotifyConnectedMeta =
      const VerificationMeta('userSpotifyConnected');
  @override
  late final GeneratedColumn<bool> userSpotifyConnected = GeneratedColumn<bool>(
      'user_spotify_connected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("user_spotify_connected" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _communityIdMeta =
      const VerificationMeta('communityId');
  @override
  late final GeneratedColumn<String> communityId = GeneratedColumn<String>(
      'community_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        userName,
        userImg,
        themeMusicImg,
        themeMusicName,
        themeMusicArtistName,
        themeMusicSpotifyUrl,
        themeMusicPreviewUrl,
        userProfileMsg,
        userSpotifyConnected,
        communityId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('user_img')) {
      context.handle(_userImgMeta,
          userImg.isAcceptableOrUnknown(data['user_img']!, _userImgMeta));
    }
    if (data.containsKey('theme_music_img')) {
      context.handle(
          _themeMusicImgMeta,
          themeMusicImg.isAcceptableOrUnknown(
              data['theme_music_img']!, _themeMusicImgMeta));
    }
    if (data.containsKey('theme_music_name')) {
      context.handle(
          _themeMusicNameMeta,
          themeMusicName.isAcceptableOrUnknown(
              data['theme_music_name']!, _themeMusicNameMeta));
    }
    if (data.containsKey('theme_music_artist_name')) {
      context.handle(
          _themeMusicArtistNameMeta,
          themeMusicArtistName.isAcceptableOrUnknown(
              data['theme_music_artist_name']!, _themeMusicArtistNameMeta));
    }
    if (data.containsKey('theme_music_spotify_url')) {
      context.handle(
          _themeMusicSpotifyUrlMeta,
          themeMusicSpotifyUrl.isAcceptableOrUnknown(
              data['theme_music_spotify_url']!, _themeMusicSpotifyUrlMeta));
    }
    if (data.containsKey('theme_music_preview_url')) {
      context.handle(
          _themeMusicPreviewUrlMeta,
          themeMusicPreviewUrl.isAcceptableOrUnknown(
              data['theme_music_preview_url']!, _themeMusicPreviewUrlMeta));
    }
    if (data.containsKey('user_profile_msg')) {
      context.handle(
          _userProfileMsgMeta,
          userProfileMsg.isAcceptableOrUnknown(
              data['user_profile_msg']!, _userProfileMsgMeta));
    }
    if (data.containsKey('user_spotify_connected')) {
      context.handle(
          _userSpotifyConnectedMeta,
          userSpotifyConnected.isAcceptableOrUnknown(
              data['user_spotify_connected']!, _userSpotifyConnectedMeta));
    }
    if (data.containsKey('community_id')) {
      context.handle(
          _communityIdMeta,
          communityId.isAcceptableOrUnknown(
              data['community_id']!, _communityIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocalUserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUserProfile(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      userImg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_img'])!,
      themeMusicImg: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}theme_music_img'])!,
      themeMusicName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}theme_music_name'])!,
      themeMusicArtistName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_music_artist_name'])!,
      themeMusicSpotifyUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_music_spotify_url'])!,
      themeMusicPreviewUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_music_preview_url']),
      userProfileMsg: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}user_profile_msg'])!,
      userSpotifyConnected: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}user_spotify_connected'])!,
      communityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}community_id'])!,
    );
  }

  @override
  $LocalUserProfilesTable createAlias(String alias) {
    return $LocalUserProfilesTable(attachedDatabase, alias);
  }
}

class LocalUserProfile extends DataClass
    implements Insertable<LocalUserProfile> {
  final String uid;
  final String userId;
  final String userName;
  final String userImg;
  final String themeMusicImg;
  final String themeMusicName;
  final String themeMusicArtistName;
  final String themeMusicSpotifyUrl;
  final String? themeMusicPreviewUrl;
  final String userProfileMsg;
  final bool userSpotifyConnected;
  final String communityId;
  const LocalUserProfile(
      {required this.uid,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.themeMusicImg,
      required this.themeMusicName,
      required this.themeMusicArtistName,
      required this.themeMusicSpotifyUrl,
      this.themeMusicPreviewUrl,
      required this.userProfileMsg,
      required this.userSpotifyConnected,
      required this.communityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['user_id'] = Variable<String>(userId);
    map['user_name'] = Variable<String>(userName);
    map['user_img'] = Variable<String>(userImg);
    map['theme_music_img'] = Variable<String>(themeMusicImg);
    map['theme_music_name'] = Variable<String>(themeMusicName);
    map['theme_music_artist_name'] = Variable<String>(themeMusicArtistName);
    map['theme_music_spotify_url'] = Variable<String>(themeMusicSpotifyUrl);
    if (!nullToAbsent || themeMusicPreviewUrl != null) {
      map['theme_music_preview_url'] = Variable<String>(themeMusicPreviewUrl);
    }
    map['user_profile_msg'] = Variable<String>(userProfileMsg);
    map['user_spotify_connected'] = Variable<bool>(userSpotifyConnected);
    map['community_id'] = Variable<String>(communityId);
    return map;
  }

  LocalUserProfilesCompanion toCompanion(bool nullToAbsent) {
    return LocalUserProfilesCompanion(
      uid: Value(uid),
      userId: Value(userId),
      userName: Value(userName),
      userImg: Value(userImg),
      themeMusicImg: Value(themeMusicImg),
      themeMusicName: Value(themeMusicName),
      themeMusicArtistName: Value(themeMusicArtistName),
      themeMusicSpotifyUrl: Value(themeMusicSpotifyUrl),
      themeMusicPreviewUrl: themeMusicPreviewUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(themeMusicPreviewUrl),
      userProfileMsg: Value(userProfileMsg),
      userSpotifyConnected: Value(userSpotifyConnected),
      communityId: Value(communityId),
    );
  }

  factory LocalUserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserProfile(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      userImg: serializer.fromJson<String>(json['userImg']),
      themeMusicImg: serializer.fromJson<String>(json['themeMusicImg']),
      themeMusicName: serializer.fromJson<String>(json['themeMusicName']),
      themeMusicArtistName:
          serializer.fromJson<String>(json['themeMusicArtistName']),
      themeMusicSpotifyUrl:
          serializer.fromJson<String>(json['themeMusicSpotifyUrl']),
      themeMusicPreviewUrl:
          serializer.fromJson<String?>(json['themeMusicPreviewUrl']),
      userProfileMsg: serializer.fromJson<String>(json['userProfileMsg']),
      userSpotifyConnected:
          serializer.fromJson<bool>(json['userSpotifyConnected']),
      communityId: serializer.fromJson<String>(json['communityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String>(userId),
      'userName': serializer.toJson<String>(userName),
      'userImg': serializer.toJson<String>(userImg),
      'themeMusicImg': serializer.toJson<String>(themeMusicImg),
      'themeMusicName': serializer.toJson<String>(themeMusicName),
      'themeMusicArtistName': serializer.toJson<String>(themeMusicArtistName),
      'themeMusicSpotifyUrl': serializer.toJson<String>(themeMusicSpotifyUrl),
      'themeMusicPreviewUrl': serializer.toJson<String?>(themeMusicPreviewUrl),
      'userProfileMsg': serializer.toJson<String>(userProfileMsg),
      'userSpotifyConnected': serializer.toJson<bool>(userSpotifyConnected),
      'communityId': serializer.toJson<String>(communityId),
    };
  }

  LocalUserProfile copyWith(
          {String? uid,
          String? userId,
          String? userName,
          String? userImg,
          String? themeMusicImg,
          String? themeMusicName,
          String? themeMusicArtistName,
          String? themeMusicSpotifyUrl,
          Value<String?> themeMusicPreviewUrl = const Value.absent(),
          String? userProfileMsg,
          bool? userSpotifyConnected,
          String? communityId}) =>
      LocalUserProfile(
        uid: uid ?? this.uid,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userImg: userImg ?? this.userImg,
        themeMusicImg: themeMusicImg ?? this.themeMusicImg,
        themeMusicName: themeMusicName ?? this.themeMusicName,
        themeMusicArtistName: themeMusicArtistName ?? this.themeMusicArtistName,
        themeMusicSpotifyUrl: themeMusicSpotifyUrl ?? this.themeMusicSpotifyUrl,
        themeMusicPreviewUrl: themeMusicPreviewUrl.present
            ? themeMusicPreviewUrl.value
            : this.themeMusicPreviewUrl,
        userProfileMsg: userProfileMsg ?? this.userProfileMsg,
        userSpotifyConnected: userSpotifyConnected ?? this.userSpotifyConnected,
        communityId: communityId ?? this.communityId,
      );
  @override
  String toString() {
    return (StringBuffer('LocalUserProfile(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userImg: $userImg, ')
          ..write('themeMusicImg: $themeMusicImg, ')
          ..write('themeMusicName: $themeMusicName, ')
          ..write('themeMusicArtistName: $themeMusicArtistName, ')
          ..write('themeMusicSpotifyUrl: $themeMusicSpotifyUrl, ')
          ..write('themeMusicPreviewUrl: $themeMusicPreviewUrl, ')
          ..write('userProfileMsg: $userProfileMsg, ')
          ..write('userSpotifyConnected: $userSpotifyConnected, ')
          ..write('communityId: $communityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      userName,
      userImg,
      themeMusicImg,
      themeMusicName,
      themeMusicArtistName,
      themeMusicSpotifyUrl,
      themeMusicPreviewUrl,
      userProfileMsg,
      userSpotifyConnected,
      communityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserProfile &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.userImg == this.userImg &&
          other.themeMusicImg == this.themeMusicImg &&
          other.themeMusicName == this.themeMusicName &&
          other.themeMusicArtistName == this.themeMusicArtistName &&
          other.themeMusicSpotifyUrl == this.themeMusicSpotifyUrl &&
          other.themeMusicPreviewUrl == this.themeMusicPreviewUrl &&
          other.userProfileMsg == this.userProfileMsg &&
          other.userSpotifyConnected == this.userSpotifyConnected &&
          other.communityId == this.communityId);
}

class LocalUserProfilesCompanion extends UpdateCompanion<LocalUserProfile> {
  final Value<String> uid;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String> userImg;
  final Value<String> themeMusicImg;
  final Value<String> themeMusicName;
  final Value<String> themeMusicArtistName;
  final Value<String> themeMusicSpotifyUrl;
  final Value<String?> themeMusicPreviewUrl;
  final Value<String> userProfileMsg;
  final Value<bool> userSpotifyConnected;
  final Value<String> communityId;
  final Value<int> rowid;
  const LocalUserProfilesCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.userImg = const Value.absent(),
    this.themeMusicImg = const Value.absent(),
    this.themeMusicName = const Value.absent(),
    this.themeMusicArtistName = const Value.absent(),
    this.themeMusicSpotifyUrl = const Value.absent(),
    this.themeMusicPreviewUrl = const Value.absent(),
    this.userProfileMsg = const Value.absent(),
    this.userSpotifyConnected = const Value.absent(),
    this.communityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUserProfilesCompanion.insert({
    required String uid,
    required String userId,
    required String userName,
    this.userImg = const Value.absent(),
    this.themeMusicImg = const Value.absent(),
    this.themeMusicName = const Value.absent(),
    this.themeMusicArtistName = const Value.absent(),
    this.themeMusicSpotifyUrl = const Value.absent(),
    this.themeMusicPreviewUrl = const Value.absent(),
    this.userProfileMsg = const Value.absent(),
    this.userSpotifyConnected = const Value.absent(),
    this.communityId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        userId = Value(userId),
        userName = Value(userName);
  static Insertable<LocalUserProfile> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? userImg,
    Expression<String>? themeMusicImg,
    Expression<String>? themeMusicName,
    Expression<String>? themeMusicArtistName,
    Expression<String>? themeMusicSpotifyUrl,
    Expression<String>? themeMusicPreviewUrl,
    Expression<String>? userProfileMsg,
    Expression<bool>? userSpotifyConnected,
    Expression<String>? communityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (userImg != null) 'user_img': userImg,
      if (themeMusicImg != null) 'theme_music_img': themeMusicImg,
      if (themeMusicName != null) 'theme_music_name': themeMusicName,
      if (themeMusicArtistName != null)
        'theme_music_artist_name': themeMusicArtistName,
      if (themeMusicSpotifyUrl != null)
        'theme_music_spotify_url': themeMusicSpotifyUrl,
      if (themeMusicPreviewUrl != null)
        'theme_music_preview_url': themeMusicPreviewUrl,
      if (userProfileMsg != null) 'user_profile_msg': userProfileMsg,
      if (userSpotifyConnected != null)
        'user_spotify_connected': userSpotifyConnected,
      if (communityId != null) 'community_id': communityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUserProfilesCompanion copyWith(
      {Value<String>? uid,
      Value<String>? userId,
      Value<String>? userName,
      Value<String>? userImg,
      Value<String>? themeMusicImg,
      Value<String>? themeMusicName,
      Value<String>? themeMusicArtistName,
      Value<String>? themeMusicSpotifyUrl,
      Value<String?>? themeMusicPreviewUrl,
      Value<String>? userProfileMsg,
      Value<bool>? userSpotifyConnected,
      Value<String>? communityId,
      Value<int>? rowid}) {
    return LocalUserProfilesCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImg: userImg ?? this.userImg,
      themeMusicImg: themeMusicImg ?? this.themeMusicImg,
      themeMusicName: themeMusicName ?? this.themeMusicName,
      themeMusicArtistName: themeMusicArtistName ?? this.themeMusicArtistName,
      themeMusicSpotifyUrl: themeMusicSpotifyUrl ?? this.themeMusicSpotifyUrl,
      themeMusicPreviewUrl: themeMusicPreviewUrl ?? this.themeMusicPreviewUrl,
      userProfileMsg: userProfileMsg ?? this.userProfileMsg,
      userSpotifyConnected: userSpotifyConnected ?? this.userSpotifyConnected,
      communityId: communityId ?? this.communityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (userImg.present) {
      map['user_img'] = Variable<String>(userImg.value);
    }
    if (themeMusicImg.present) {
      map['theme_music_img'] = Variable<String>(themeMusicImg.value);
    }
    if (themeMusicName.present) {
      map['theme_music_name'] = Variable<String>(themeMusicName.value);
    }
    if (themeMusicArtistName.present) {
      map['theme_music_artist_name'] =
          Variable<String>(themeMusicArtistName.value);
    }
    if (themeMusicSpotifyUrl.present) {
      map['theme_music_spotify_url'] =
          Variable<String>(themeMusicSpotifyUrl.value);
    }
    if (themeMusicPreviewUrl.present) {
      map['theme_music_preview_url'] =
          Variable<String>(themeMusicPreviewUrl.value);
    }
    if (userProfileMsg.present) {
      map['user_profile_msg'] = Variable<String>(userProfileMsg.value);
    }
    if (userSpotifyConnected.present) {
      map['user_spotify_connected'] =
          Variable<bool>(userSpotifyConnected.value);
    }
    if (communityId.present) {
      map['community_id'] = Variable<String>(communityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserProfilesCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userImg: $userImg, ')
          ..write('themeMusicImg: $themeMusicImg, ')
          ..write('themeMusicName: $themeMusicName, ')
          ..write('themeMusicArtistName: $themeMusicArtistName, ')
          ..write('themeMusicSpotifyUrl: $themeMusicSpotifyUrl, ')
          ..write('themeMusicPreviewUrl: $themeMusicPreviewUrl, ')
          ..write('userProfileMsg: $userProfileMsg, ')
          ..write('userSpotifyConnected: $userSpotifyConnected, ')
          ..write('communityId: $communityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUserFavoriteArtistsTable extends LocalUserFavoriteArtists
    with TableInfo<$LocalUserFavoriteArtistsTable, LocalUserFavoriteArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUserFavoriteArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userFavoriteArtistIdMeta =
      const VerificationMeta('userFavoriteArtistId');
  @override
  late final GeneratedColumn<String> userFavoriteArtistId =
      GeneratedColumn<String>('user_favorite_artist_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userFavoriteArtistNameMeta =
      const VerificationMeta('userFavoriteArtistName');
  @override
  late final GeneratedColumn<String> userFavoriteArtistName =
      GeneratedColumn<String>('user_favorite_artist_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userFavoriteArtistImgMeta =
      const VerificationMeta('userFavoriteArtistImg');
  @override
  late final GeneratedColumn<String> userFavoriteArtistImg =
      GeneratedColumn<String>('user_favorite_artist_img', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userFavoriteArtistId,
        userFavoriteArtistName,
        userFavoriteArtistImg
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_user_favorite_artists';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalUserFavoriteArtist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_favorite_artist_id')) {
      context.handle(
          _userFavoriteArtistIdMeta,
          userFavoriteArtistId.isAcceptableOrUnknown(
              data['user_favorite_artist_id']!, _userFavoriteArtistIdMeta));
    } else if (isInserting) {
      context.missing(_userFavoriteArtistIdMeta);
    }
    if (data.containsKey('user_favorite_artist_name')) {
      context.handle(
          _userFavoriteArtistNameMeta,
          userFavoriteArtistName.isAcceptableOrUnknown(
              data['user_favorite_artist_name']!, _userFavoriteArtistNameMeta));
    } else if (isInserting) {
      context.missing(_userFavoriteArtistNameMeta);
    }
    if (data.containsKey('user_favorite_artist_img')) {
      context.handle(
          _userFavoriteArtistImgMeta,
          userFavoriteArtistImg.isAcceptableOrUnknown(
              data['user_favorite_artist_img']!, _userFavoriteArtistImgMeta));
    } else if (isInserting) {
      context.missing(_userFavoriteArtistImgMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocalUserFavoriteArtist map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUserFavoriteArtist(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userFavoriteArtistId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_id'])!,
      userFavoriteArtistName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_name'])!,
      userFavoriteArtistImg: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_img'])!,
    );
  }

  @override
  $LocalUserFavoriteArtistsTable createAlias(String alias) {
    return $LocalUserFavoriteArtistsTable(attachedDatabase, alias);
  }
}

class LocalUserFavoriteArtist extends DataClass
    implements Insertable<LocalUserFavoriteArtist> {
  final String uid;
  final String userFavoriteArtistId;
  final String userFavoriteArtistName;
  final String userFavoriteArtistImg;
  const LocalUserFavoriteArtist(
      {required this.uid,
      required this.userFavoriteArtistId,
      required this.userFavoriteArtistName,
      required this.userFavoriteArtistImg});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['user_favorite_artist_id'] = Variable<String>(userFavoriteArtistId);
    map['user_favorite_artist_name'] = Variable<String>(userFavoriteArtistName);
    map['user_favorite_artist_img'] = Variable<String>(userFavoriteArtistImg);
    return map;
  }

  LocalUserFavoriteArtistsCompanion toCompanion(bool nullToAbsent) {
    return LocalUserFavoriteArtistsCompanion(
      uid: Value(uid),
      userFavoriteArtistId: Value(userFavoriteArtistId),
      userFavoriteArtistName: Value(userFavoriteArtistName),
      userFavoriteArtistImg: Value(userFavoriteArtistImg),
    );
  }

  factory LocalUserFavoriteArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserFavoriteArtist(
      uid: serializer.fromJson<String>(json['uid']),
      userFavoriteArtistId:
          serializer.fromJson<String>(json['userFavoriteArtistId']),
      userFavoriteArtistName:
          serializer.fromJson<String>(json['userFavoriteArtistName']),
      userFavoriteArtistImg:
          serializer.fromJson<String>(json['userFavoriteArtistImg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userFavoriteArtistId': serializer.toJson<String>(userFavoriteArtistId),
      'userFavoriteArtistName':
          serializer.toJson<String>(userFavoriteArtistName),
      'userFavoriteArtistImg': serializer.toJson<String>(userFavoriteArtistImg),
    };
  }

  LocalUserFavoriteArtist copyWith(
          {String? uid,
          String? userFavoriteArtistId,
          String? userFavoriteArtistName,
          String? userFavoriteArtistImg}) =>
      LocalUserFavoriteArtist(
        uid: uid ?? this.uid,
        userFavoriteArtistId: userFavoriteArtistId ?? this.userFavoriteArtistId,
        userFavoriteArtistName:
            userFavoriteArtistName ?? this.userFavoriteArtistName,
        userFavoriteArtistImg:
            userFavoriteArtistImg ?? this.userFavoriteArtistImg,
      );
  @override
  String toString() {
    return (StringBuffer('LocalUserFavoriteArtist(')
          ..write('uid: $uid, ')
          ..write('userFavoriteArtistId: $userFavoriteArtistId, ')
          ..write('userFavoriteArtistName: $userFavoriteArtistName, ')
          ..write('userFavoriteArtistImg: $userFavoriteArtistImg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid, userFavoriteArtistId, userFavoriteArtistName, userFavoriteArtistImg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserFavoriteArtist &&
          other.uid == this.uid &&
          other.userFavoriteArtistId == this.userFavoriteArtistId &&
          other.userFavoriteArtistName == this.userFavoriteArtistName &&
          other.userFavoriteArtistImg == this.userFavoriteArtistImg);
}

class LocalUserFavoriteArtistsCompanion
    extends UpdateCompanion<LocalUserFavoriteArtist> {
  final Value<String> uid;
  final Value<String> userFavoriteArtistId;
  final Value<String> userFavoriteArtistName;
  final Value<String> userFavoriteArtistImg;
  final Value<int> rowid;
  const LocalUserFavoriteArtistsCompanion({
    this.uid = const Value.absent(),
    this.userFavoriteArtistId = const Value.absent(),
    this.userFavoriteArtistName = const Value.absent(),
    this.userFavoriteArtistImg = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUserFavoriteArtistsCompanion.insert({
    required String uid,
    required String userFavoriteArtistId,
    required String userFavoriteArtistName,
    required String userFavoriteArtistImg,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        userFavoriteArtistId = Value(userFavoriteArtistId),
        userFavoriteArtistName = Value(userFavoriteArtistName),
        userFavoriteArtistImg = Value(userFavoriteArtistImg);
  static Insertable<LocalUserFavoriteArtist> custom({
    Expression<String>? uid,
    Expression<String>? userFavoriteArtistId,
    Expression<String>? userFavoriteArtistName,
    Expression<String>? userFavoriteArtistImg,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userFavoriteArtistId != null)
        'user_favorite_artist_id': userFavoriteArtistId,
      if (userFavoriteArtistName != null)
        'user_favorite_artist_name': userFavoriteArtistName,
      if (userFavoriteArtistImg != null)
        'user_favorite_artist_img': userFavoriteArtistImg,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUserFavoriteArtistsCompanion copyWith(
      {Value<String>? uid,
      Value<String>? userFavoriteArtistId,
      Value<String>? userFavoriteArtistName,
      Value<String>? userFavoriteArtistImg,
      Value<int>? rowid}) {
    return LocalUserFavoriteArtistsCompanion(
      uid: uid ?? this.uid,
      userFavoriteArtistId: userFavoriteArtistId ?? this.userFavoriteArtistId,
      userFavoriteArtistName:
          userFavoriteArtistName ?? this.userFavoriteArtistName,
      userFavoriteArtistImg:
          userFavoriteArtistImg ?? this.userFavoriteArtistImg,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userFavoriteArtistId.present) {
      map['user_favorite_artist_id'] =
          Variable<String>(userFavoriteArtistId.value);
    }
    if (userFavoriteArtistName.present) {
      map['user_favorite_artist_name'] =
          Variable<String>(userFavoriteArtistName.value);
    }
    if (userFavoriteArtistImg.present) {
      map['user_favorite_artist_img'] =
          Variable<String>(userFavoriteArtistImg.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserFavoriteArtistsCompanion(')
          ..write('uid: $uid, ')
          ..write('userFavoriteArtistId: $userFavoriteArtistId, ')
          ..write('userFavoriteArtistName: $userFavoriteArtistName, ')
          ..write('userFavoriteArtistImg: $userFavoriteArtistImg, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUserPostsTable extends LocalUserPosts
    with TableInfo<$LocalUserPostsTable, LocalUserPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUserPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postMusicImgMeta =
      const VerificationMeta('postMusicImg');
  @override
  late final GeneratedColumn<String> postMusicImg = GeneratedColumn<String>(
      'post_music_img', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postMusicAritstNameMeta =
      const VerificationMeta('postMusicAritstName');
  @override
  late final GeneratedColumn<String> postMusicAritstName =
      GeneratedColumn<String>('post_music_aritst_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postMusicNameMeta =
      const VerificationMeta('postMusicName');
  @override
  late final GeneratedColumn<String> postMusicName = GeneratedColumn<String>(
      'post_music_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postMsgMeta =
      const VerificationMeta('postMsg');
  @override
  late final GeneratedColumn<String> postMsg = GeneratedColumn<String>(
      'post_msg', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postTimestampMeta =
      const VerificationMeta('postTimestamp');
  @override
  late final GeneratedColumn<DateTime> postTimestamp =
      GeneratedColumn<DateTime>('post_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _postMusicSpotifyUrlMeta =
      const VerificationMeta('postMusicSpotifyUrl');
  @override
  late final GeneratedColumn<String> postMusicSpotifyUrl =
      GeneratedColumn<String>('post_music_spotify_url', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postMusicPreciewUrlMeta =
      const VerificationMeta('postMusicPreciewUrl');
  @override
  late final GeneratedColumn<String> postMusicPreciewUrl =
      GeneratedColumn<String>('post_music_preciew_url', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        postId,
        postMusicImg,
        postMusicAritstName,
        postMusicName,
        postMsg,
        postTimestamp,
        postMusicSpotifyUrl,
        postMusicPreciewUrl
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_user_posts';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUserPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('post_music_img')) {
      context.handle(
          _postMusicImgMeta,
          postMusicImg.isAcceptableOrUnknown(
              data['post_music_img']!, _postMusicImgMeta));
    } else if (isInserting) {
      context.missing(_postMusicImgMeta);
    }
    if (data.containsKey('post_music_aritst_name')) {
      context.handle(
          _postMusicAritstNameMeta,
          postMusicAritstName.isAcceptableOrUnknown(
              data['post_music_aritst_name']!, _postMusicAritstNameMeta));
    } else if (isInserting) {
      context.missing(_postMusicAritstNameMeta);
    }
    if (data.containsKey('post_music_name')) {
      context.handle(
          _postMusicNameMeta,
          postMusicName.isAcceptableOrUnknown(
              data['post_music_name']!, _postMusicNameMeta));
    } else if (isInserting) {
      context.missing(_postMusicNameMeta);
    }
    if (data.containsKey('post_msg')) {
      context.handle(_postMsgMeta,
          postMsg.isAcceptableOrUnknown(data['post_msg']!, _postMsgMeta));
    } else if (isInserting) {
      context.missing(_postMsgMeta);
    }
    if (data.containsKey('post_timestamp')) {
      context.handle(
          _postTimestampMeta,
          postTimestamp.isAcceptableOrUnknown(
              data['post_timestamp']!, _postTimestampMeta));
    } else if (isInserting) {
      context.missing(_postTimestampMeta);
    }
    if (data.containsKey('post_music_spotify_url')) {
      context.handle(
          _postMusicSpotifyUrlMeta,
          postMusicSpotifyUrl.isAcceptableOrUnknown(
              data['post_music_spotify_url']!, _postMusicSpotifyUrlMeta));
    } else if (isInserting) {
      context.missing(_postMusicSpotifyUrlMeta);
    }
    if (data.containsKey('post_music_preciew_url')) {
      context.handle(
          _postMusicPreciewUrlMeta,
          postMusicPreciewUrl.isAcceptableOrUnknown(
              data['post_music_preciew_url']!, _postMusicPreciewUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocalUserPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUserPost(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id'])!,
      postMusicImg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_music_img'])!,
      postMusicAritstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}post_music_aritst_name'])!,
      postMusicName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}post_music_name'])!,
      postMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_msg'])!,
      postTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}post_timestamp'])!,
      postMusicSpotifyUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}post_music_spotify_url'])!,
      postMusicPreciewUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}post_music_preciew_url'])!,
    );
  }

  @override
  $LocalUserPostsTable createAlias(String alias) {
    return $LocalUserPostsTable(attachedDatabase, alias);
  }
}

class LocalUserPost extends DataClass implements Insertable<LocalUserPost> {
  final String uid;
  final String postId;
  final String postMusicImg;
  final String postMusicAritstName;
  final String postMusicName;
  final String postMsg;
  final DateTime postTimestamp;
  final String postMusicSpotifyUrl;
  final String postMusicPreciewUrl;
  const LocalUserPost(
      {required this.uid,
      required this.postId,
      required this.postMusicImg,
      required this.postMusicAritstName,
      required this.postMusicName,
      required this.postMsg,
      required this.postTimestamp,
      required this.postMusicSpotifyUrl,
      required this.postMusicPreciewUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['post_id'] = Variable<String>(postId);
    map['post_music_img'] = Variable<String>(postMusicImg);
    map['post_music_aritst_name'] = Variable<String>(postMusicAritstName);
    map['post_music_name'] = Variable<String>(postMusicName);
    map['post_msg'] = Variable<String>(postMsg);
    map['post_timestamp'] = Variable<DateTime>(postTimestamp);
    map['post_music_spotify_url'] = Variable<String>(postMusicSpotifyUrl);
    map['post_music_preciew_url'] = Variable<String>(postMusicPreciewUrl);
    return map;
  }

  LocalUserPostsCompanion toCompanion(bool nullToAbsent) {
    return LocalUserPostsCompanion(
      uid: Value(uid),
      postId: Value(postId),
      postMusicImg: Value(postMusicImg),
      postMusicAritstName: Value(postMusicAritstName),
      postMusicName: Value(postMusicName),
      postMsg: Value(postMsg),
      postTimestamp: Value(postTimestamp),
      postMusicSpotifyUrl: Value(postMusicSpotifyUrl),
      postMusicPreciewUrl: Value(postMusicPreciewUrl),
    );
  }

  factory LocalUserPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserPost(
      uid: serializer.fromJson<String>(json['uid']),
      postId: serializer.fromJson<String>(json['postId']),
      postMusicImg: serializer.fromJson<String>(json['postMusicImg']),
      postMusicAritstName:
          serializer.fromJson<String>(json['postMusicAritstName']),
      postMusicName: serializer.fromJson<String>(json['postMusicName']),
      postMsg: serializer.fromJson<String>(json['postMsg']),
      postTimestamp: serializer.fromJson<DateTime>(json['postTimestamp']),
      postMusicSpotifyUrl:
          serializer.fromJson<String>(json['postMusicSpotifyUrl']),
      postMusicPreciewUrl:
          serializer.fromJson<String>(json['postMusicPreciewUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'postId': serializer.toJson<String>(postId),
      'postMusicImg': serializer.toJson<String>(postMusicImg),
      'postMusicAritstName': serializer.toJson<String>(postMusicAritstName),
      'postMusicName': serializer.toJson<String>(postMusicName),
      'postMsg': serializer.toJson<String>(postMsg),
      'postTimestamp': serializer.toJson<DateTime>(postTimestamp),
      'postMusicSpotifyUrl': serializer.toJson<String>(postMusicSpotifyUrl),
      'postMusicPreciewUrl': serializer.toJson<String>(postMusicPreciewUrl),
    };
  }

  LocalUserPost copyWith(
          {String? uid,
          String? postId,
          String? postMusicImg,
          String? postMusicAritstName,
          String? postMusicName,
          String? postMsg,
          DateTime? postTimestamp,
          String? postMusicSpotifyUrl,
          String? postMusicPreciewUrl}) =>
      LocalUserPost(
        uid: uid ?? this.uid,
        postId: postId ?? this.postId,
        postMusicImg: postMusicImg ?? this.postMusicImg,
        postMusicAritstName: postMusicAritstName ?? this.postMusicAritstName,
        postMusicName: postMusicName ?? this.postMusicName,
        postMsg: postMsg ?? this.postMsg,
        postTimestamp: postTimestamp ?? this.postTimestamp,
        postMusicSpotifyUrl: postMusicSpotifyUrl ?? this.postMusicSpotifyUrl,
        postMusicPreciewUrl: postMusicPreciewUrl ?? this.postMusicPreciewUrl,
      );
  @override
  String toString() {
    return (StringBuffer('LocalUserPost(')
          ..write('uid: $uid, ')
          ..write('postId: $postId, ')
          ..write('postMusicImg: $postMusicImg, ')
          ..write('postMusicAritstName: $postMusicAritstName, ')
          ..write('postMusicName: $postMusicName, ')
          ..write('postMsg: $postMsg, ')
          ..write('postTimestamp: $postTimestamp, ')
          ..write('postMusicSpotifyUrl: $postMusicSpotifyUrl, ')
          ..write('postMusicPreciewUrl: $postMusicPreciewUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      postId,
      postMusicImg,
      postMusicAritstName,
      postMusicName,
      postMsg,
      postTimestamp,
      postMusicSpotifyUrl,
      postMusicPreciewUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserPost &&
          other.uid == this.uid &&
          other.postId == this.postId &&
          other.postMusicImg == this.postMusicImg &&
          other.postMusicAritstName == this.postMusicAritstName &&
          other.postMusicName == this.postMusicName &&
          other.postMsg == this.postMsg &&
          other.postTimestamp == this.postTimestamp &&
          other.postMusicSpotifyUrl == this.postMusicSpotifyUrl &&
          other.postMusicPreciewUrl == this.postMusicPreciewUrl);
}

class LocalUserPostsCompanion extends UpdateCompanion<LocalUserPost> {
  final Value<String> uid;
  final Value<String> postId;
  final Value<String> postMusicImg;
  final Value<String> postMusicAritstName;
  final Value<String> postMusicName;
  final Value<String> postMsg;
  final Value<DateTime> postTimestamp;
  final Value<String> postMusicSpotifyUrl;
  final Value<String> postMusicPreciewUrl;
  final Value<int> rowid;
  const LocalUserPostsCompanion({
    this.uid = const Value.absent(),
    this.postId = const Value.absent(),
    this.postMusicImg = const Value.absent(),
    this.postMusicAritstName = const Value.absent(),
    this.postMusicName = const Value.absent(),
    this.postMsg = const Value.absent(),
    this.postTimestamp = const Value.absent(),
    this.postMusicSpotifyUrl = const Value.absent(),
    this.postMusicPreciewUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUserPostsCompanion.insert({
    required String uid,
    required String postId,
    required String postMusicImg,
    required String postMusicAritstName,
    required String postMusicName,
    required String postMsg,
    required DateTime postTimestamp,
    required String postMusicSpotifyUrl,
    this.postMusicPreciewUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        postId = Value(postId),
        postMusicImg = Value(postMusicImg),
        postMusicAritstName = Value(postMusicAritstName),
        postMusicName = Value(postMusicName),
        postMsg = Value(postMsg),
        postTimestamp = Value(postTimestamp),
        postMusicSpotifyUrl = Value(postMusicSpotifyUrl);
  static Insertable<LocalUserPost> custom({
    Expression<String>? uid,
    Expression<String>? postId,
    Expression<String>? postMusicImg,
    Expression<String>? postMusicAritstName,
    Expression<String>? postMusicName,
    Expression<String>? postMsg,
    Expression<DateTime>? postTimestamp,
    Expression<String>? postMusicSpotifyUrl,
    Expression<String>? postMusicPreciewUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (postId != null) 'post_id': postId,
      if (postMusicImg != null) 'post_music_img': postMusicImg,
      if (postMusicAritstName != null)
        'post_music_aritst_name': postMusicAritstName,
      if (postMusicName != null) 'post_music_name': postMusicName,
      if (postMsg != null) 'post_msg': postMsg,
      if (postTimestamp != null) 'post_timestamp': postTimestamp,
      if (postMusicSpotifyUrl != null)
        'post_music_spotify_url': postMusicSpotifyUrl,
      if (postMusicPreciewUrl != null)
        'post_music_preciew_url': postMusicPreciewUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUserPostsCompanion copyWith(
      {Value<String>? uid,
      Value<String>? postId,
      Value<String>? postMusicImg,
      Value<String>? postMusicAritstName,
      Value<String>? postMusicName,
      Value<String>? postMsg,
      Value<DateTime>? postTimestamp,
      Value<String>? postMusicSpotifyUrl,
      Value<String>? postMusicPreciewUrl,
      Value<int>? rowid}) {
    return LocalUserPostsCompanion(
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      postMusicImg: postMusicImg ?? this.postMusicImg,
      postMusicAritstName: postMusicAritstName ?? this.postMusicAritstName,
      postMusicName: postMusicName ?? this.postMusicName,
      postMsg: postMsg ?? this.postMsg,
      postTimestamp: postTimestamp ?? this.postTimestamp,
      postMusicSpotifyUrl: postMusicSpotifyUrl ?? this.postMusicSpotifyUrl,
      postMusicPreciewUrl: postMusicPreciewUrl ?? this.postMusicPreciewUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (postMusicImg.present) {
      map['post_music_img'] = Variable<String>(postMusicImg.value);
    }
    if (postMusicAritstName.present) {
      map['post_music_aritst_name'] =
          Variable<String>(postMusicAritstName.value);
    }
    if (postMusicName.present) {
      map['post_music_name'] = Variable<String>(postMusicName.value);
    }
    if (postMsg.present) {
      map['post_msg'] = Variable<String>(postMsg.value);
    }
    if (postTimestamp.present) {
      map['post_timestamp'] = Variable<DateTime>(postTimestamp.value);
    }
    if (postMusicSpotifyUrl.present) {
      map['post_music_spotify_url'] =
          Variable<String>(postMusicSpotifyUrl.value);
    }
    if (postMusicPreciewUrl.present) {
      map['post_music_preciew_url'] =
          Variable<String>(postMusicPreciewUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserPostsCompanion(')
          ..write('uid: $uid, ')
          ..write('postId: $postId, ')
          ..write('postMusicImg: $postMusicImg, ')
          ..write('postMusicAritstName: $postMusicAritstName, ')
          ..write('postMusicName: $postMusicName, ')
          ..write('postMsg: $postMsg, ')
          ..write('postTimestamp: $postTimestamp, ')
          ..write('postMusicSpotifyUrl: $postMusicSpotifyUrl, ')
          ..write('postMusicPreciewUrl: $postMusicPreciewUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $LocalUserProfilesTable localUserProfiles =
      $LocalUserProfilesTable(this);
  late final $LocalUserFavoriteArtistsTable localUserFavoriteArtists =
      $LocalUserFavoriteArtistsTable(this);
  late final $LocalUserPostsTable localUserPosts = $LocalUserPostsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [localUserProfiles, localUserFavoriteArtists, localUserPosts];
}
