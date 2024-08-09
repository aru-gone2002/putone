import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

//データのモデルを定義
//というアノテーションを使って、このテーブルの各行の型の名前をTodoItemに設定します。これにより、このテーブルの各行はTodoItemという型を持つことになります。←書かなくても自動でやってくれる
@DataClassName('UserBaseProfile')
class UserBaseProfiles extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().withLength(min: 4, max: 20)();
  TextColumn get userName => text().withLength(min: 1, max: 20)();
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
      text().withDefault(const Constant('')).withLength(min: 0, max: 120)();
  BoolColumn get userSpotifyConnected =>
      boolean().withDefault(const Constant(false))();
  TextColumn get communityId => text().withDefault(const Constant('none'))();
}

//AppDatabaseがDriftのデータベースであり、
//そのデータのテーブルズとしてTodoItemsのリストを指定
@DriftDatabase(tables: [UserBaseProfiles])
class AppDatabase extends _$AppDatabase {
  //AppDatabaseをインスタンス化した際に_openConnection()を実行することを明記
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

/// データベースから全てのUserBaseProfileをストリームとして取得する。
/// UserBaseProfileが追加、更新、削除されると、このストリームは新しいリストを返す。
Stream<List<UserBaseProfile>> watchAllUserBaseProfiles(AppDatabase db) {
  return db.select(db.userBaseProfiles).watch();
}

/// データベースから全てのUserBaseProfileを一度だけ取得する。
Future<List<UserBaseProfile>> getAllUserBaseProfiles(AppDatabase db) {
  return db.select(db.userBaseProfiles).get();
}

/// 新しいUserBaseProfileをデータベースに挿入する。
Future insertUserBaseProfile(AppDatabase db, UserBaseProfile userBaseProfile) {
  return db.into(db.userBaseProfiles).insert(userBaseProfile);
}

/// UserBaseProfileを更新する。
Future updateUserBaseProfile(AppDatabase db, UserBaseProfile userBaseProfile) {
  return db.update(db.userBaseProfiles).replace(userBaseProfile);
}

/// データベースからUserBaseProfileを削除する。
Future deleteUserBaseProfile(AppDatabase db, UserBaseProfile userBaseProfile) {
  return db.delete(db.userBaseProfiles).delete(userBaseProfile);
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
