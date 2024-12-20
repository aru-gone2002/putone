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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 80),
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
  static const VerificationMeta _userSignUpTimestampMeta =
      const VerificationMeta('userSignUpTimestamp');
  @override
  late final GeneratedColumn<DateTime> userSignUpTimestamp =
      GeneratedColumn<DateTime>('user_sign_up_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userLastLoginTimestampMeta =
      const VerificationMeta('userLastLoginTimestamp');
  @override
  late final GeneratedColumn<DateTime> userLastLoginTimestamp =
      GeneratedColumn<DateTime>('user_last_login_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
        userSignUpTimestamp,
        userLastLoginTimestamp,
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
    if (data.containsKey('user_sign_up_timestamp')) {
      context.handle(
          _userSignUpTimestampMeta,
          userSignUpTimestamp.isAcceptableOrUnknown(
              data['user_sign_up_timestamp']!, _userSignUpTimestampMeta));
    } else if (isInserting) {
      context.missing(_userSignUpTimestampMeta);
    }
    if (data.containsKey('user_last_login_timestamp')) {
      context.handle(
          _userLastLoginTimestampMeta,
          userLastLoginTimestamp.isAcceptableOrUnknown(
              data['user_last_login_timestamp']!, _userLastLoginTimestampMeta));
    } else if (isInserting) {
      context.missing(_userLastLoginTimestampMeta);
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
      userSignUpTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}user_sign_up_timestamp'])!,
      userLastLoginTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}user_last_login_timestamp'])!,
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
  final DateTime userSignUpTimestamp;
  final DateTime userLastLoginTimestamp;
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
      required this.userSignUpTimestamp,
      required this.userLastLoginTimestamp,
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
    map['user_sign_up_timestamp'] = Variable<DateTime>(userSignUpTimestamp);
    map['user_last_login_timestamp'] =
        Variable<DateTime>(userLastLoginTimestamp);
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
      userSignUpTimestamp: Value(userSignUpTimestamp),
      userLastLoginTimestamp: Value(userLastLoginTimestamp),
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
      userSignUpTimestamp:
          serializer.fromJson<DateTime>(json['userSignUpTimestamp']),
      userLastLoginTimestamp:
          serializer.fromJson<DateTime>(json['userLastLoginTimestamp']),
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
      'userSignUpTimestamp': serializer.toJson<DateTime>(userSignUpTimestamp),
      'userLastLoginTimestamp':
          serializer.toJson<DateTime>(userLastLoginTimestamp),
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
          DateTime? userSignUpTimestamp,
          DateTime? userLastLoginTimestamp,
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
        userSignUpTimestamp: userSignUpTimestamp ?? this.userSignUpTimestamp,
        userLastLoginTimestamp:
            userLastLoginTimestamp ?? this.userLastLoginTimestamp,
        communityId: communityId ?? this.communityId,
      );
  LocalUserProfile copyWithCompanion(LocalUserProfilesCompanion data) {
    return LocalUserProfile(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      userImg: data.userImg.present ? data.userImg.value : this.userImg,
      themeMusicImg: data.themeMusicImg.present
          ? data.themeMusicImg.value
          : this.themeMusicImg,
      themeMusicName: data.themeMusicName.present
          ? data.themeMusicName.value
          : this.themeMusicName,
      themeMusicArtistName: data.themeMusicArtistName.present
          ? data.themeMusicArtistName.value
          : this.themeMusicArtistName,
      themeMusicSpotifyUrl: data.themeMusicSpotifyUrl.present
          ? data.themeMusicSpotifyUrl.value
          : this.themeMusicSpotifyUrl,
      themeMusicPreviewUrl: data.themeMusicPreviewUrl.present
          ? data.themeMusicPreviewUrl.value
          : this.themeMusicPreviewUrl,
      userProfileMsg: data.userProfileMsg.present
          ? data.userProfileMsg.value
          : this.userProfileMsg,
      userSpotifyConnected: data.userSpotifyConnected.present
          ? data.userSpotifyConnected.value
          : this.userSpotifyConnected,
      userSignUpTimestamp: data.userSignUpTimestamp.present
          ? data.userSignUpTimestamp.value
          : this.userSignUpTimestamp,
      userLastLoginTimestamp: data.userLastLoginTimestamp.present
          ? data.userLastLoginTimestamp.value
          : this.userLastLoginTimestamp,
      communityId:
          data.communityId.present ? data.communityId.value : this.communityId,
    );
  }

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
          ..write('userSignUpTimestamp: $userSignUpTimestamp, ')
          ..write('userLastLoginTimestamp: $userLastLoginTimestamp, ')
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
      userSignUpTimestamp,
      userLastLoginTimestamp,
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
          other.userSignUpTimestamp == this.userSignUpTimestamp &&
          other.userLastLoginTimestamp == this.userLastLoginTimestamp &&
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
  final Value<DateTime> userSignUpTimestamp;
  final Value<DateTime> userLastLoginTimestamp;
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
    this.userSignUpTimestamp = const Value.absent(),
    this.userLastLoginTimestamp = const Value.absent(),
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
    required DateTime userSignUpTimestamp,
    required DateTime userLastLoginTimestamp,
    this.communityId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        userId = Value(userId),
        userName = Value(userName),
        userSignUpTimestamp = Value(userSignUpTimestamp),
        userLastLoginTimestamp = Value(userLastLoginTimestamp);
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
    Expression<DateTime>? userSignUpTimestamp,
    Expression<DateTime>? userLastLoginTimestamp,
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
      if (userSignUpTimestamp != null)
        'user_sign_up_timestamp': userSignUpTimestamp,
      if (userLastLoginTimestamp != null)
        'user_last_login_timestamp': userLastLoginTimestamp,
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
      Value<DateTime>? userSignUpTimestamp,
      Value<DateTime>? userLastLoginTimestamp,
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
      userSignUpTimestamp: userSignUpTimestamp ?? this.userSignUpTimestamp,
      userLastLoginTimestamp:
          userLastLoginTimestamp ?? this.userLastLoginTimestamp,
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
    if (userSignUpTimestamp.present) {
      map['user_sign_up_timestamp'] =
          Variable<DateTime>(userSignUpTimestamp.value);
    }
    if (userLastLoginTimestamp.present) {
      map['user_last_login_timestamp'] =
          Variable<DateTime>(userLastLoginTimestamp.value);
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
          ..write('userSignUpTimestamp: $userSignUpTimestamp, ')
          ..write('userLastLoginTimestamp: $userLastLoginTimestamp, ')
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
  static const VerificationMeta _userFavoriteArtistSpotifyUrlMeta =
      const VerificationMeta('userFavoriteArtistSpotifyUrl');
  @override
  late final GeneratedColumn<String> userFavoriteArtistSpotifyUrl =
      GeneratedColumn<String>(
          'user_favorite_artist_spotify_url', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        userFavoriteArtistId,
        userFavoriteArtistName,
        userFavoriteArtistImg,
        userFavoriteArtistSpotifyUrl
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
    if (data.containsKey('user_favorite_artist_spotify_url')) {
      context.handle(
          _userFavoriteArtistSpotifyUrlMeta,
          userFavoriteArtistSpotifyUrl.isAcceptableOrUnknown(
              data['user_favorite_artist_spotify_url']!,
              _userFavoriteArtistSpotifyUrlMeta));
    } else if (isInserting) {
      context.missing(_userFavoriteArtistSpotifyUrlMeta);
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
      userFavoriteArtistId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_id'])!,
      userFavoriteArtistName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_name'])!,
      userFavoriteArtistImg: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_img'])!,
      userFavoriteArtistSpotifyUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_favorite_artist_spotify_url'])!,
    );
  }

  @override
  $LocalUserFavoriteArtistsTable createAlias(String alias) {
    return $LocalUserFavoriteArtistsTable(attachedDatabase, alias);
  }
}

class LocalUserFavoriteArtist extends DataClass
    implements Insertable<LocalUserFavoriteArtist> {
  final String userFavoriteArtistId;
  final String userFavoriteArtistName;
  final String userFavoriteArtistImg;
  final String userFavoriteArtistSpotifyUrl;
  const LocalUserFavoriteArtist(
      {required this.userFavoriteArtistId,
      required this.userFavoriteArtistName,
      required this.userFavoriteArtistImg,
      required this.userFavoriteArtistSpotifyUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_favorite_artist_id'] = Variable<String>(userFavoriteArtistId);
    map['user_favorite_artist_name'] = Variable<String>(userFavoriteArtistName);
    map['user_favorite_artist_img'] = Variable<String>(userFavoriteArtistImg);
    map['user_favorite_artist_spotify_url'] =
        Variable<String>(userFavoriteArtistSpotifyUrl);
    return map;
  }

  LocalUserFavoriteArtistsCompanion toCompanion(bool nullToAbsent) {
    return LocalUserFavoriteArtistsCompanion(
      userFavoriteArtistId: Value(userFavoriteArtistId),
      userFavoriteArtistName: Value(userFavoriteArtistName),
      userFavoriteArtistImg: Value(userFavoriteArtistImg),
      userFavoriteArtistSpotifyUrl: Value(userFavoriteArtistSpotifyUrl),
    );
  }

  factory LocalUserFavoriteArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserFavoriteArtist(
      userFavoriteArtistId:
          serializer.fromJson<String>(json['userFavoriteArtistId']),
      userFavoriteArtistName:
          serializer.fromJson<String>(json['userFavoriteArtistName']),
      userFavoriteArtistImg:
          serializer.fromJson<String>(json['userFavoriteArtistImg']),
      userFavoriteArtistSpotifyUrl:
          serializer.fromJson<String>(json['userFavoriteArtistSpotifyUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userFavoriteArtistId': serializer.toJson<String>(userFavoriteArtistId),
      'userFavoriteArtistName':
          serializer.toJson<String>(userFavoriteArtistName),
      'userFavoriteArtistImg': serializer.toJson<String>(userFavoriteArtistImg),
      'userFavoriteArtistSpotifyUrl':
          serializer.toJson<String>(userFavoriteArtistSpotifyUrl),
    };
  }

  LocalUserFavoriteArtist copyWith(
          {String? userFavoriteArtistId,
          String? userFavoriteArtistName,
          String? userFavoriteArtistImg,
          String? userFavoriteArtistSpotifyUrl}) =>
      LocalUserFavoriteArtist(
        userFavoriteArtistId: userFavoriteArtistId ?? this.userFavoriteArtistId,
        userFavoriteArtistName:
            userFavoriteArtistName ?? this.userFavoriteArtistName,
        userFavoriteArtistImg:
            userFavoriteArtistImg ?? this.userFavoriteArtistImg,
        userFavoriteArtistSpotifyUrl:
            userFavoriteArtistSpotifyUrl ?? this.userFavoriteArtistSpotifyUrl,
      );
  LocalUserFavoriteArtist copyWithCompanion(
      LocalUserFavoriteArtistsCompanion data) {
    return LocalUserFavoriteArtist(
      userFavoriteArtistId: data.userFavoriteArtistId.present
          ? data.userFavoriteArtistId.value
          : this.userFavoriteArtistId,
      userFavoriteArtistName: data.userFavoriteArtistName.present
          ? data.userFavoriteArtistName.value
          : this.userFavoriteArtistName,
      userFavoriteArtistImg: data.userFavoriteArtistImg.present
          ? data.userFavoriteArtistImg.value
          : this.userFavoriteArtistImg,
      userFavoriteArtistSpotifyUrl: data.userFavoriteArtistSpotifyUrl.present
          ? data.userFavoriteArtistSpotifyUrl.value
          : this.userFavoriteArtistSpotifyUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserFavoriteArtist(')
          ..write('userFavoriteArtistId: $userFavoriteArtistId, ')
          ..write('userFavoriteArtistName: $userFavoriteArtistName, ')
          ..write('userFavoriteArtistImg: $userFavoriteArtistImg, ')
          ..write('userFavoriteArtistSpotifyUrl: $userFavoriteArtistSpotifyUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userFavoriteArtistId, userFavoriteArtistName,
      userFavoriteArtistImg, userFavoriteArtistSpotifyUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserFavoriteArtist &&
          other.userFavoriteArtistId == this.userFavoriteArtistId &&
          other.userFavoriteArtistName == this.userFavoriteArtistName &&
          other.userFavoriteArtistImg == this.userFavoriteArtistImg &&
          other.userFavoriteArtistSpotifyUrl ==
              this.userFavoriteArtistSpotifyUrl);
}

class LocalUserFavoriteArtistsCompanion
    extends UpdateCompanion<LocalUserFavoriteArtist> {
  final Value<String> userFavoriteArtistId;
  final Value<String> userFavoriteArtistName;
  final Value<String> userFavoriteArtistImg;
  final Value<String> userFavoriteArtistSpotifyUrl;
  final Value<int> rowid;
  const LocalUserFavoriteArtistsCompanion({
    this.userFavoriteArtistId = const Value.absent(),
    this.userFavoriteArtistName = const Value.absent(),
    this.userFavoriteArtistImg = const Value.absent(),
    this.userFavoriteArtistSpotifyUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUserFavoriteArtistsCompanion.insert({
    required String userFavoriteArtistId,
    required String userFavoriteArtistName,
    required String userFavoriteArtistImg,
    required String userFavoriteArtistSpotifyUrl,
    this.rowid = const Value.absent(),
  })  : userFavoriteArtistId = Value(userFavoriteArtistId),
        userFavoriteArtistName = Value(userFavoriteArtistName),
        userFavoriteArtistImg = Value(userFavoriteArtistImg),
        userFavoriteArtistSpotifyUrl = Value(userFavoriteArtistSpotifyUrl);
  static Insertable<LocalUserFavoriteArtist> custom({
    Expression<String>? userFavoriteArtistId,
    Expression<String>? userFavoriteArtistName,
    Expression<String>? userFavoriteArtistImg,
    Expression<String>? userFavoriteArtistSpotifyUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userFavoriteArtistId != null)
        'user_favorite_artist_id': userFavoriteArtistId,
      if (userFavoriteArtistName != null)
        'user_favorite_artist_name': userFavoriteArtistName,
      if (userFavoriteArtistImg != null)
        'user_favorite_artist_img': userFavoriteArtistImg,
      if (userFavoriteArtistSpotifyUrl != null)
        'user_favorite_artist_spotify_url': userFavoriteArtistSpotifyUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUserFavoriteArtistsCompanion copyWith(
      {Value<String>? userFavoriteArtistId,
      Value<String>? userFavoriteArtistName,
      Value<String>? userFavoriteArtistImg,
      Value<String>? userFavoriteArtistSpotifyUrl,
      Value<int>? rowid}) {
    return LocalUserFavoriteArtistsCompanion(
      userFavoriteArtistId: userFavoriteArtistId ?? this.userFavoriteArtistId,
      userFavoriteArtistName:
          userFavoriteArtistName ?? this.userFavoriteArtistName,
      userFavoriteArtistImg:
          userFavoriteArtistImg ?? this.userFavoriteArtistImg,
      userFavoriteArtistSpotifyUrl:
          userFavoriteArtistSpotifyUrl ?? this.userFavoriteArtistSpotifyUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
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
    if (userFavoriteArtistSpotifyUrl.present) {
      map['user_favorite_artist_spotify_url'] =
          Variable<String>(userFavoriteArtistSpotifyUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserFavoriteArtistsCompanion(')
          ..write('userFavoriteArtistId: $userFavoriteArtistId, ')
          ..write('userFavoriteArtistName: $userFavoriteArtistName, ')
          ..write('userFavoriteArtistImg: $userFavoriteArtistImg, ')
          ..write(
              'userFavoriteArtistSpotifyUrl: $userFavoriteArtistSpotifyUrl, ')
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
  static const VerificationMeta _postMusicArtistNameMeta =
      const VerificationMeta('postMusicArtistName');
  @override
  late final GeneratedColumn<String> postMusicArtistName =
      GeneratedColumn<String>('post_music_artist_name', aliasedName, false,
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
      GeneratedColumn<String>('post_music_preciew_url', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        postId,
        postMusicImg,
        postMusicArtistName,
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
    if (data.containsKey('post_music_artist_name')) {
      context.handle(
          _postMusicArtistNameMeta,
          postMusicArtistName.isAcceptableOrUnknown(
              data['post_music_artist_name']!, _postMusicArtistNameMeta));
    } else if (isInserting) {
      context.missing(_postMusicArtistNameMeta);
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
      postMusicArtistName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}post_music_artist_name'])!,
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
          data['${effectivePrefix}post_music_preciew_url']),
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
  final String postMusicArtistName;
  final String postMusicName;
  final String postMsg;
  final DateTime postTimestamp;
  final String postMusicSpotifyUrl;
  final String? postMusicPreciewUrl;
  const LocalUserPost(
      {required this.uid,
      required this.postId,
      required this.postMusicImg,
      required this.postMusicArtistName,
      required this.postMusicName,
      required this.postMsg,
      required this.postTimestamp,
      required this.postMusicSpotifyUrl,
      this.postMusicPreciewUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['post_id'] = Variable<String>(postId);
    map['post_music_img'] = Variable<String>(postMusicImg);
    map['post_music_artist_name'] = Variable<String>(postMusicArtistName);
    map['post_music_name'] = Variable<String>(postMusicName);
    map['post_msg'] = Variable<String>(postMsg);
    map['post_timestamp'] = Variable<DateTime>(postTimestamp);
    map['post_music_spotify_url'] = Variable<String>(postMusicSpotifyUrl);
    if (!nullToAbsent || postMusicPreciewUrl != null) {
      map['post_music_preciew_url'] = Variable<String>(postMusicPreciewUrl);
    }
    return map;
  }

  LocalUserPostsCompanion toCompanion(bool nullToAbsent) {
    return LocalUserPostsCompanion(
      uid: Value(uid),
      postId: Value(postId),
      postMusicImg: Value(postMusicImg),
      postMusicArtistName: Value(postMusicArtistName),
      postMusicName: Value(postMusicName),
      postMsg: Value(postMsg),
      postTimestamp: Value(postTimestamp),
      postMusicSpotifyUrl: Value(postMusicSpotifyUrl),
      postMusicPreciewUrl: postMusicPreciewUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(postMusicPreciewUrl),
    );
  }

  factory LocalUserPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserPost(
      uid: serializer.fromJson<String>(json['uid']),
      postId: serializer.fromJson<String>(json['postId']),
      postMusicImg: serializer.fromJson<String>(json['postMusicImg']),
      postMusicArtistName:
          serializer.fromJson<String>(json['postMusicArtistName']),
      postMusicName: serializer.fromJson<String>(json['postMusicName']),
      postMsg: serializer.fromJson<String>(json['postMsg']),
      postTimestamp: serializer.fromJson<DateTime>(json['postTimestamp']),
      postMusicSpotifyUrl:
          serializer.fromJson<String>(json['postMusicSpotifyUrl']),
      postMusicPreciewUrl:
          serializer.fromJson<String?>(json['postMusicPreciewUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'postId': serializer.toJson<String>(postId),
      'postMusicImg': serializer.toJson<String>(postMusicImg),
      'postMusicArtistName': serializer.toJson<String>(postMusicArtistName),
      'postMusicName': serializer.toJson<String>(postMusicName),
      'postMsg': serializer.toJson<String>(postMsg),
      'postTimestamp': serializer.toJson<DateTime>(postTimestamp),
      'postMusicSpotifyUrl': serializer.toJson<String>(postMusicSpotifyUrl),
      'postMusicPreciewUrl': serializer.toJson<String?>(postMusicPreciewUrl),
    };
  }

  LocalUserPost copyWith(
          {String? uid,
          String? postId,
          String? postMusicImg,
          String? postMusicArtistName,
          String? postMusicName,
          String? postMsg,
          DateTime? postTimestamp,
          String? postMusicSpotifyUrl,
          Value<String?> postMusicPreciewUrl = const Value.absent()}) =>
      LocalUserPost(
        uid: uid ?? this.uid,
        postId: postId ?? this.postId,
        postMusicImg: postMusicImg ?? this.postMusicImg,
        postMusicArtistName: postMusicArtistName ?? this.postMusicArtistName,
        postMusicName: postMusicName ?? this.postMusicName,
        postMsg: postMsg ?? this.postMsg,
        postTimestamp: postTimestamp ?? this.postTimestamp,
        postMusicSpotifyUrl: postMusicSpotifyUrl ?? this.postMusicSpotifyUrl,
        postMusicPreciewUrl: postMusicPreciewUrl.present
            ? postMusicPreciewUrl.value
            : this.postMusicPreciewUrl,
      );
  LocalUserPost copyWithCompanion(LocalUserPostsCompanion data) {
    return LocalUserPost(
      uid: data.uid.present ? data.uid.value : this.uid,
      postId: data.postId.present ? data.postId.value : this.postId,
      postMusicImg: data.postMusicImg.present
          ? data.postMusicImg.value
          : this.postMusicImg,
      postMusicArtistName: data.postMusicArtistName.present
          ? data.postMusicArtistName.value
          : this.postMusicArtistName,
      postMusicName: data.postMusicName.present
          ? data.postMusicName.value
          : this.postMusicName,
      postMsg: data.postMsg.present ? data.postMsg.value : this.postMsg,
      postTimestamp: data.postTimestamp.present
          ? data.postTimestamp.value
          : this.postTimestamp,
      postMusicSpotifyUrl: data.postMusicSpotifyUrl.present
          ? data.postMusicSpotifyUrl.value
          : this.postMusicSpotifyUrl,
      postMusicPreciewUrl: data.postMusicPreciewUrl.present
          ? data.postMusicPreciewUrl.value
          : this.postMusicPreciewUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserPost(')
          ..write('uid: $uid, ')
          ..write('postId: $postId, ')
          ..write('postMusicImg: $postMusicImg, ')
          ..write('postMusicArtistName: $postMusicArtistName, ')
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
      postMusicArtistName,
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
          other.postMusicArtistName == this.postMusicArtistName &&
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
  final Value<String> postMusicArtistName;
  final Value<String> postMusicName;
  final Value<String> postMsg;
  final Value<DateTime> postTimestamp;
  final Value<String> postMusicSpotifyUrl;
  final Value<String?> postMusicPreciewUrl;
  final Value<int> rowid;
  const LocalUserPostsCompanion({
    this.uid = const Value.absent(),
    this.postId = const Value.absent(),
    this.postMusicImg = const Value.absent(),
    this.postMusicArtistName = const Value.absent(),
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
    required String postMusicArtistName,
    required String postMusicName,
    required String postMsg,
    required DateTime postTimestamp,
    required String postMusicSpotifyUrl,
    this.postMusicPreciewUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        postId = Value(postId),
        postMusicImg = Value(postMusicImg),
        postMusicArtistName = Value(postMusicArtistName),
        postMusicName = Value(postMusicName),
        postMsg = Value(postMsg),
        postTimestamp = Value(postTimestamp),
        postMusicSpotifyUrl = Value(postMusicSpotifyUrl);
  static Insertable<LocalUserPost> custom({
    Expression<String>? uid,
    Expression<String>? postId,
    Expression<String>? postMusicImg,
    Expression<String>? postMusicArtistName,
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
      if (postMusicArtistName != null)
        'post_music_artist_name': postMusicArtistName,
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
      Value<String>? postMusicArtistName,
      Value<String>? postMusicName,
      Value<String>? postMsg,
      Value<DateTime>? postTimestamp,
      Value<String>? postMusicSpotifyUrl,
      Value<String?>? postMusicPreciewUrl,
      Value<int>? rowid}) {
    return LocalUserPostsCompanion(
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      postMusicImg: postMusicImg ?? this.postMusicImg,
      postMusicArtistName: postMusicArtistName ?? this.postMusicArtistName,
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
    if (postMusicArtistName.present) {
      map['post_music_artist_name'] =
          Variable<String>(postMusicArtistName.value);
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
          ..write('postMusicArtistName: $postMusicArtistName, ')
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
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
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

typedef $$LocalUserProfilesTableCreateCompanionBuilder
    = LocalUserProfilesCompanion Function({
  required String uid,
  required String userId,
  required String userName,
  Value<String> userImg,
  Value<String> themeMusicImg,
  Value<String> themeMusicName,
  Value<String> themeMusicArtistName,
  Value<String> themeMusicSpotifyUrl,
  Value<String?> themeMusicPreviewUrl,
  Value<String> userProfileMsg,
  Value<bool> userSpotifyConnected,
  required DateTime userSignUpTimestamp,
  required DateTime userLastLoginTimestamp,
  Value<String> communityId,
  Value<int> rowid,
});
typedef $$LocalUserProfilesTableUpdateCompanionBuilder
    = LocalUserProfilesCompanion Function({
  Value<String> uid,
  Value<String> userId,
  Value<String> userName,
  Value<String> userImg,
  Value<String> themeMusicImg,
  Value<String> themeMusicName,
  Value<String> themeMusicArtistName,
  Value<String> themeMusicSpotifyUrl,
  Value<String?> themeMusicPreviewUrl,
  Value<String> userProfileMsg,
  Value<bool> userSpotifyConnected,
  Value<DateTime> userSignUpTimestamp,
  Value<DateTime> userLastLoginTimestamp,
  Value<String> communityId,
  Value<int> rowid,
});

class $$LocalUserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUserProfilesTable,
    LocalUserProfile,
    $$LocalUserProfilesTableFilterComposer,
    $$LocalUserProfilesTableOrderingComposer,
    $$LocalUserProfilesTableCreateCompanionBuilder,
    $$LocalUserProfilesTableUpdateCompanionBuilder> {
  $$LocalUserProfilesTableTableManager(
      _$AppDatabase db, $LocalUserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocalUserProfilesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$LocalUserProfilesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<String> userImg = const Value.absent(),
            Value<String> themeMusicImg = const Value.absent(),
            Value<String> themeMusicName = const Value.absent(),
            Value<String> themeMusicArtistName = const Value.absent(),
            Value<String> themeMusicSpotifyUrl = const Value.absent(),
            Value<String?> themeMusicPreviewUrl = const Value.absent(),
            Value<String> userProfileMsg = const Value.absent(),
            Value<bool> userSpotifyConnected = const Value.absent(),
            Value<DateTime> userSignUpTimestamp = const Value.absent(),
            Value<DateTime> userLastLoginTimestamp = const Value.absent(),
            Value<String> communityId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserProfilesCompanion(
            uid: uid,
            userId: userId,
            userName: userName,
            userImg: userImg,
            themeMusicImg: themeMusicImg,
            themeMusicName: themeMusicName,
            themeMusicArtistName: themeMusicArtistName,
            themeMusicSpotifyUrl: themeMusicSpotifyUrl,
            themeMusicPreviewUrl: themeMusicPreviewUrl,
            userProfileMsg: userProfileMsg,
            userSpotifyConnected: userSpotifyConnected,
            userSignUpTimestamp: userSignUpTimestamp,
            userLastLoginTimestamp: userLastLoginTimestamp,
            communityId: communityId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String userId,
            required String userName,
            Value<String> userImg = const Value.absent(),
            Value<String> themeMusicImg = const Value.absent(),
            Value<String> themeMusicName = const Value.absent(),
            Value<String> themeMusicArtistName = const Value.absent(),
            Value<String> themeMusicSpotifyUrl = const Value.absent(),
            Value<String?> themeMusicPreviewUrl = const Value.absent(),
            Value<String> userProfileMsg = const Value.absent(),
            Value<bool> userSpotifyConnected = const Value.absent(),
            required DateTime userSignUpTimestamp,
            required DateTime userLastLoginTimestamp,
            Value<String> communityId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserProfilesCompanion.insert(
            uid: uid,
            userId: userId,
            userName: userName,
            userImg: userImg,
            themeMusicImg: themeMusicImg,
            themeMusicName: themeMusicName,
            themeMusicArtistName: themeMusicArtistName,
            themeMusicSpotifyUrl: themeMusicSpotifyUrl,
            themeMusicPreviewUrl: themeMusicPreviewUrl,
            userProfileMsg: userProfileMsg,
            userSpotifyConnected: userSpotifyConnected,
            userSignUpTimestamp: userSignUpTimestamp,
            userLastLoginTimestamp: userLastLoginTimestamp,
            communityId: communityId,
            rowid: rowid,
          ),
        ));
}

class $$LocalUserProfilesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LocalUserProfilesTable> {
  $$LocalUserProfilesTableFilterComposer(super.$state);
  ColumnFilters<String> get uid => $state.composableBuilder(
      column: $state.table.uid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userName => $state.composableBuilder(
      column: $state.table.userName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userImg => $state.composableBuilder(
      column: $state.table.userImg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMusicImg => $state.composableBuilder(
      column: $state.table.themeMusicImg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMusicName => $state.composableBuilder(
      column: $state.table.themeMusicName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMusicArtistName => $state.composableBuilder(
      column: $state.table.themeMusicArtistName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMusicSpotifyUrl => $state.composableBuilder(
      column: $state.table.themeMusicSpotifyUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMusicPreviewUrl => $state.composableBuilder(
      column: $state.table.themeMusicPreviewUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userProfileMsg => $state.composableBuilder(
      column: $state.table.userProfileMsg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get userSpotifyConnected => $state.composableBuilder(
      column: $state.table.userSpotifyConnected,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get userSignUpTimestamp => $state.composableBuilder(
      column: $state.table.userSignUpTimestamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get userLastLoginTimestamp =>
      $state.composableBuilder(
          column: $state.table.userLastLoginTimestamp,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get communityId => $state.composableBuilder(
      column: $state.table.communityId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LocalUserProfilesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LocalUserProfilesTable> {
  $$LocalUserProfilesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get uid => $state.composableBuilder(
      column: $state.table.uid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userName => $state.composableBuilder(
      column: $state.table.userName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userImg => $state.composableBuilder(
      column: $state.table.userImg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMusicImg => $state.composableBuilder(
      column: $state.table.themeMusicImg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMusicName => $state.composableBuilder(
      column: $state.table.themeMusicName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMusicArtistName => $state.composableBuilder(
      column: $state.table.themeMusicArtistName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMusicSpotifyUrl => $state.composableBuilder(
      column: $state.table.themeMusicSpotifyUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMusicPreviewUrl => $state.composableBuilder(
      column: $state.table.themeMusicPreviewUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userProfileMsg => $state.composableBuilder(
      column: $state.table.userProfileMsg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get userSpotifyConnected => $state.composableBuilder(
      column: $state.table.userSpotifyConnected,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get userSignUpTimestamp => $state.composableBuilder(
      column: $state.table.userSignUpTimestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get userLastLoginTimestamp =>
      $state.composableBuilder(
          column: $state.table.userLastLoginTimestamp,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get communityId => $state.composableBuilder(
      column: $state.table.communityId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LocalUserFavoriteArtistsTableCreateCompanionBuilder
    = LocalUserFavoriteArtistsCompanion Function({
  required String userFavoriteArtistId,
  required String userFavoriteArtistName,
  required String userFavoriteArtistImg,
  required String userFavoriteArtistSpotifyUrl,
  Value<int> rowid,
});
typedef $$LocalUserFavoriteArtistsTableUpdateCompanionBuilder
    = LocalUserFavoriteArtistsCompanion Function({
  Value<String> userFavoriteArtistId,
  Value<String> userFavoriteArtistName,
  Value<String> userFavoriteArtistImg,
  Value<String> userFavoriteArtistSpotifyUrl,
  Value<int> rowid,
});

class $$LocalUserFavoriteArtistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUserFavoriteArtistsTable,
    LocalUserFavoriteArtist,
    $$LocalUserFavoriteArtistsTableFilterComposer,
    $$LocalUserFavoriteArtistsTableOrderingComposer,
    $$LocalUserFavoriteArtistsTableCreateCompanionBuilder,
    $$LocalUserFavoriteArtistsTableUpdateCompanionBuilder> {
  $$LocalUserFavoriteArtistsTableTableManager(
      _$AppDatabase db, $LocalUserFavoriteArtistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$LocalUserFavoriteArtistsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$LocalUserFavoriteArtistsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> userFavoriteArtistId = const Value.absent(),
            Value<String> userFavoriteArtistName = const Value.absent(),
            Value<String> userFavoriteArtistImg = const Value.absent(),
            Value<String> userFavoriteArtistSpotifyUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserFavoriteArtistsCompanion(
            userFavoriteArtistId: userFavoriteArtistId,
            userFavoriteArtistName: userFavoriteArtistName,
            userFavoriteArtistImg: userFavoriteArtistImg,
            userFavoriteArtistSpotifyUrl: userFavoriteArtistSpotifyUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userFavoriteArtistId,
            required String userFavoriteArtistName,
            required String userFavoriteArtistImg,
            required String userFavoriteArtistSpotifyUrl,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserFavoriteArtistsCompanion.insert(
            userFavoriteArtistId: userFavoriteArtistId,
            userFavoriteArtistName: userFavoriteArtistName,
            userFavoriteArtistImg: userFavoriteArtistImg,
            userFavoriteArtistSpotifyUrl: userFavoriteArtistSpotifyUrl,
            rowid: rowid,
          ),
        ));
}

class $$LocalUserFavoriteArtistsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LocalUserFavoriteArtistsTable> {
  $$LocalUserFavoriteArtistsTableFilterComposer(super.$state);
  ColumnFilters<String> get userFavoriteArtistId => $state.composableBuilder(
      column: $state.table.userFavoriteArtistId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userFavoriteArtistName => $state.composableBuilder(
      column: $state.table.userFavoriteArtistName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userFavoriteArtistImg => $state.composableBuilder(
      column: $state.table.userFavoriteArtistImg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userFavoriteArtistSpotifyUrl =>
      $state.composableBuilder(
          column: $state.table.userFavoriteArtistSpotifyUrl,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LocalUserFavoriteArtistsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LocalUserFavoriteArtistsTable> {
  $$LocalUserFavoriteArtistsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get userFavoriteArtistId => $state.composableBuilder(
      column: $state.table.userFavoriteArtistId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userFavoriteArtistName =>
      $state.composableBuilder(
          column: $state.table.userFavoriteArtistName,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userFavoriteArtistImg => $state.composableBuilder(
      column: $state.table.userFavoriteArtistImg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userFavoriteArtistSpotifyUrl =>
      $state.composableBuilder(
          column: $state.table.userFavoriteArtistSpotifyUrl,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LocalUserPostsTableCreateCompanionBuilder = LocalUserPostsCompanion
    Function({
  required String uid,
  required String postId,
  required String postMusicImg,
  required String postMusicArtistName,
  required String postMusicName,
  required String postMsg,
  required DateTime postTimestamp,
  required String postMusicSpotifyUrl,
  Value<String?> postMusicPreciewUrl,
  Value<int> rowid,
});
typedef $$LocalUserPostsTableUpdateCompanionBuilder = LocalUserPostsCompanion
    Function({
  Value<String> uid,
  Value<String> postId,
  Value<String> postMusicImg,
  Value<String> postMusicArtistName,
  Value<String> postMusicName,
  Value<String> postMsg,
  Value<DateTime> postTimestamp,
  Value<String> postMusicSpotifyUrl,
  Value<String?> postMusicPreciewUrl,
  Value<int> rowid,
});

class $$LocalUserPostsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUserPostsTable,
    LocalUserPost,
    $$LocalUserPostsTableFilterComposer,
    $$LocalUserPostsTableOrderingComposer,
    $$LocalUserPostsTableCreateCompanionBuilder,
    $$LocalUserPostsTableUpdateCompanionBuilder> {
  $$LocalUserPostsTableTableManager(
      _$AppDatabase db, $LocalUserPostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocalUserPostsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LocalUserPostsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> postId = const Value.absent(),
            Value<String> postMusicImg = const Value.absent(),
            Value<String> postMusicArtistName = const Value.absent(),
            Value<String> postMusicName = const Value.absent(),
            Value<String> postMsg = const Value.absent(),
            Value<DateTime> postTimestamp = const Value.absent(),
            Value<String> postMusicSpotifyUrl = const Value.absent(),
            Value<String?> postMusicPreciewUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserPostsCompanion(
            uid: uid,
            postId: postId,
            postMusicImg: postMusicImg,
            postMusicArtistName: postMusicArtistName,
            postMusicName: postMusicName,
            postMsg: postMsg,
            postTimestamp: postTimestamp,
            postMusicSpotifyUrl: postMusicSpotifyUrl,
            postMusicPreciewUrl: postMusicPreciewUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String postId,
            required String postMusicImg,
            required String postMusicArtistName,
            required String postMusicName,
            required String postMsg,
            required DateTime postTimestamp,
            required String postMusicSpotifyUrl,
            Value<String?> postMusicPreciewUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUserPostsCompanion.insert(
            uid: uid,
            postId: postId,
            postMusicImg: postMusicImg,
            postMusicArtistName: postMusicArtistName,
            postMusicName: postMusicName,
            postMsg: postMsg,
            postTimestamp: postTimestamp,
            postMusicSpotifyUrl: postMusicSpotifyUrl,
            postMusicPreciewUrl: postMusicPreciewUrl,
            rowid: rowid,
          ),
        ));
}

class $$LocalUserPostsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LocalUserPostsTable> {
  $$LocalUserPostsTableFilterComposer(super.$state);
  ColumnFilters<String> get uid => $state.composableBuilder(
      column: $state.table.uid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postId => $state.composableBuilder(
      column: $state.table.postId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMusicImg => $state.composableBuilder(
      column: $state.table.postMusicImg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMusicArtistName => $state.composableBuilder(
      column: $state.table.postMusicArtistName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMusicName => $state.composableBuilder(
      column: $state.table.postMusicName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMsg => $state.composableBuilder(
      column: $state.table.postMsg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get postTimestamp => $state.composableBuilder(
      column: $state.table.postTimestamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMusicSpotifyUrl => $state.composableBuilder(
      column: $state.table.postMusicSpotifyUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postMusicPreciewUrl => $state.composableBuilder(
      column: $state.table.postMusicPreciewUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LocalUserPostsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LocalUserPostsTable> {
  $$LocalUserPostsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get uid => $state.composableBuilder(
      column: $state.table.uid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postId => $state.composableBuilder(
      column: $state.table.postId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMusicImg => $state.composableBuilder(
      column: $state.table.postMusicImg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMusicArtistName => $state.composableBuilder(
      column: $state.table.postMusicArtistName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMusicName => $state.composableBuilder(
      column: $state.table.postMusicName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMsg => $state.composableBuilder(
      column: $state.table.postMsg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get postTimestamp => $state.composableBuilder(
      column: $state.table.postTimestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMusicSpotifyUrl => $state.composableBuilder(
      column: $state.table.postMusicSpotifyUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postMusicPreciewUrl => $state.composableBuilder(
      column: $state.table.postMusicPreciewUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUserProfilesTableTableManager get localUserProfiles =>
      $$LocalUserProfilesTableTableManager(_db, _db.localUserProfiles);
  $$LocalUserFavoriteArtistsTableTableManager get localUserFavoriteArtists =>
      $$LocalUserFavoriteArtistsTableTableManager(
          _db, _db.localUserFavoriteArtists);
  $$LocalUserPostsTableTableManager get localUserPosts =>
      $$LocalUserPostsTableTableManager(_db, _db.localUserPosts);
}
