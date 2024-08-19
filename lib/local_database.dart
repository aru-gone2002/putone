import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:drift/native.dart';

part 'local_database.g.dart';

//データのモデルを定義
//というアノテーションを使って、このテーブルの各行の型の名前をTodoItemに設定します。これにより、このテーブルの各行はTodoItemという型を持つことになります。←書かなくても自動でやってくれる
@DataClassName('LocalUserProfile')
class LocalUserProfiles extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().withLength(min: 4, max: 16)();
  TextColumn get userName => text().withLength(min: 1, max: 16)();
  TextColumn get userImg => text().withDefault(const Constant(''))();
  TextColumn get themeMusicImg => text().withDefault(const Constant(''))();
  TextColumn get themeMusicName => text().withDefault(const Constant(''))();
  TextColumn get themeMusicArtistName =>
      text().withDefault(const Constant(''))();
  TextColumn get themeMusicSpotifyUrl =>
      text().withDefault(const Constant(''))();
  TextColumn get themeMusicPreviewUrl =>
      text().withDefault(const Constant('')).nullable()();
  TextColumn get userProfileMsg =>
      text().withDefault(const Constant('')).withLength(min: 0, max: 80)();
  BoolColumn get userSpotifyConnected =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get userSignUpTimestamp => dateTime()();
  DateTimeColumn get userLastLoginTimestamp => dateTime()();
  TextColumn get communityId => text().withDefault(const Constant('none'))();
}

//お気に入りアーティストのテーブル
@DataClassName('LocalUserFavoriteArtist')
class LocalUserFavoriteArtists extends Table {
  TextColumn get uid => text()();
  TextColumn get userFavoriteArtistId => text()();
  TextColumn get userFavoriteArtistName => text()();
  TextColumn get userFavoriteArtistImg => text()();
}

@DataClassName('LocalUserPost')
class LocalUserPosts extends Table {
  TextColumn get uid => text()();
  TextColumn get postId => text()();
  TextColumn get postMusicImg => text()();
  TextColumn get postMusicAritstName => text()();
  TextColumn get postMusicName => text()();
  TextColumn get postMsg => text()();
  DateTimeColumn get postTimestamp => dateTime()();
  TextColumn get postMusicSpotifyUrl => text()();
  TextColumn get postMusicPreciewUrl =>
      text().withDefault(const Constant(''))();
}

//AppDatabaseがDriftのデータベースであり、
//そのデータのテーブルズとしてTodoItemsのリストを指定
@DriftDatabase(tables: [
  LocalUserProfiles,
  LocalUserFavoriteArtists,
  LocalUserPosts,
])
class AppDatabase extends _$AppDatabase {
  //AppDatabaseをインスタンス化した際に_openConnection()を実行することを明記
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// データベースから全てのUserBaseProfileをストリームとして取得する。
  /// UserBaseProfileが追加、更新、削除されると、このストリームは新しいリストを返す。
  Stream<List<LocalUserProfile>> watchAllUserBaseProfiles() {
    return (select(localUserProfiles)).watch();
  }

  /// データベースから全てのUserBaseProfileを一度だけ取得する。
  Future<List<LocalUserProfile>> getAllUserBaseProfiles() {
    return (select(localUserProfiles)).get();
  }

  /// 新しいUserBaseProfileをデータベースに挿入する。
  Future insertLocalUserProfile(UserProfile userProfile) {
    return into(localUserProfiles)
        .insert(changeUserProfileToLocalUserProfiles(userProfile));
  }

  ///UserProfileをLocalUserProfilesCompanionに変換する
  LocalUserProfilesCompanion changeUserProfileToLocalUserProfiles(
      UserProfile userProfile) {
    return LocalUserProfilesCompanion(
      uid: Value(userProfile.uid),
      userId: Value(userProfile.userId),
      userName: Value(userProfile.userName),
      userImg: Value(userProfile.userImg),
      themeMusicImg: Value(userProfile.themeMusicImg),
      themeMusicName: Value(userProfile.themeMusicName),
      themeMusicArtistName: Value(userProfile.themeMusicArtistName),
      themeMusicSpotifyUrl: Value(userProfile.themeMusicSpotifyUrl),
      themeMusicPreviewUrl: Value(userProfile.themeMusicPreviewUrl),
      userProfileMsg: Value(userProfile.userProfileMsg),
      userSpotifyConnected: Value(userProfile.userSpotifyConnected),
      userSignUpTimestamp: Value(userProfile.userSignUpTimestamp),
      userLastLoginTimestamp: Value(userProfile.userLastLoginTimestamp),
      communityId: Value(userProfile.communityId),
    );
  }

  /// UserBaseProfileを更新する。
  Future<bool> updateLocalUserProfile(UserProfile userProfile) {
    return (update(localUserProfiles)).replace(
      changeUserProfileToLocalUserProfiles(userProfile),
    );
  }

  /// データベースからLocalUserProfileを削除する。
  Future deleteLocalUserProfile() {
    return delete(localUserProfiles).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFloder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFloder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      //package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
