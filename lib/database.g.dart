// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserBaseProfilesTable extends UserBaseProfiles
    with TableInfo<$UserBaseProfilesTable, UserBaseProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserBaseProfilesTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'user_base_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserBaseProfile> instance,
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
  UserBaseProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserBaseProfile(
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
  $UserBaseProfilesTable createAlias(String alias) {
    return $UserBaseProfilesTable(attachedDatabase, alias);
  }
}

class UserBaseProfile extends DataClass implements Insertable<UserBaseProfile> {
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
  const UserBaseProfile(
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

  UserBaseProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserBaseProfilesCompanion(
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

  factory UserBaseProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserBaseProfile(
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

  UserBaseProfile copyWith(
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
      UserBaseProfile(
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
    return (StringBuffer('UserBaseProfile(')
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
      (other is UserBaseProfile &&
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

class UserBaseProfilesCompanion extends UpdateCompanion<UserBaseProfile> {
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
  const UserBaseProfilesCompanion({
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
  UserBaseProfilesCompanion.insert({
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
  static Insertable<UserBaseProfile> custom({
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

  UserBaseProfilesCompanion copyWith(
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
    return UserBaseProfilesCompanion(
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
    return (StringBuffer('UserBaseProfilesCompanion(')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UserBaseProfilesTable userBaseProfiles =
      $UserBaseProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userBaseProfiles];
}
