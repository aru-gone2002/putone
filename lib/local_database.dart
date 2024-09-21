import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:putone/data/artist/artist.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_answer/post_answer.dart';
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
  TextColumn get userId => text()();
  TextColumn get userName => text()();
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
  TextColumn get userFavoriteArtistId => text()();
  TextColumn get userFavoriteArtistName => text()();
  TextColumn get userFavoriteArtistImg => text()();
  TextColumn get userFavoriteArtistSpotifyUrl => text()();
}

@DataClassName('LocalUserPost')
class LocalUserPosts extends Table {
  TextColumn get uid => text()();
  TextColumn get postId => text()();
  TextColumn get postMusicImg => text()();
  TextColumn get postMusicArtistName => text()();
  TextColumn get postMusicName => text()();
  TextColumn get postMsg => text()();
  DateTimeColumn get postTimestamp => dateTime()();
  TextColumn get postMusicSpotifyUrl => text()();
  TextColumn get postMusicPreciewUrl =>
      text().withDefault(const Constant('')).nullable()();
}

@DataClassName('LocalUserPostAnswer')
class LocalUserPostAnswers extends Table {
  TextColumn get postId => text()();
  TextColumn get replyUid => text()();
  TextColumn get replyUserName => text()();
  TextColumn get replyUserId => text()();
  TextColumn get replyUserImg => text()();
  TextColumn get answerUid => text()();
  TextColumn get posterUid => text()();
  TextColumn get posterUserName => text()();
  TextColumn get posterUserImg => text()();
  TextColumn get quizChoice1Uid => text()();
  TextColumn get quizChoice1UserName => text()();
  TextColumn get quizChoice1UserImg => text()();
  TextColumn get quizChoice2Uid => text()();
  TextColumn get quizChoice2UserName => text()();
  TextColumn get quizChoice2UserImg => text()();
  DateTimeColumn get answerTimestamp => dateTime()();
}

//AppDatabaseがDriftのローカルDBであり、
//そのデータのテーブルズとしてTodoItemsのリストを指定
@DriftDatabase(tables: [
  LocalUserProfiles,
  LocalUserFavoriteArtists,
  LocalUserPosts,
  LocalUserPostAnswers,
])
class AppDatabase extends _$AppDatabase {
  //AppDatabaseをインスタンス化した際に_openConnection()を実行することを明記
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //----ユーザーのプロフィール情報----
  // ローカルDBから全てのLocalUserProfileをストリームとして取得する。
  // LocalUserProfileが追加、更新、削除されると、このストリームは新しいリストを返す。
  Stream<List<LocalUserProfile>> watchAllLocalUserProfiles() {
    return (select(localUserProfiles)).watch();
  }

  // ローカルDBから全てのLocalUserProfileを一度だけ取得する。
  Future<List<LocalUserProfile>> getLocalUserProfiles() {
    return (select(localUserProfiles)).get();
  }

  // 新しいLocalUserProfileをローカルDBに挿入する。
  Future insertLocalUserProfile(UserProfile userProfile) {
    return into(localUserProfiles)
        .insert(changeUserProfileToLocalUserProfile(userProfile));
  }

  // LocalUserProfilesを更新する。
  Future updateLocalUserProfile(UserProfile userProfile) {
    return (update(localUserProfiles)
          ..where(
            (tbl) => tbl.uid.equals(userProfile.uid),
          ))
        .write(
      changeUserProfileToLocalUserProfile(userProfile),
    );
  }

  // ローカルDBからLocalUserProfileを削除する。
  Future deleteLocalUserProfile() {
    return delete(localUserProfiles).go();
  }

  Future updateLocalUserName(
      {required String uid, required String newUserName}) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        userName: Value(newUserName),
      ),
    );
  }

  Future updateLocalUserId({required String uid, required String newUserId}) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        userId: Value(newUserId),
      ),
    );
  }

  Future updateLocalUserImg({required String uid, required String newUserImg}) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        userImg: Value(newUserImg),
      ),
    );
  }

  Future updateLocalThemeMusicInfo({
    required String uid,
    required String newThemeMusicArtistName,
    required String newThemeMusicName,
    required String newThemeMusicImg,
    required String newThemeMusicSpotifyUrl,
    required String newThemeMusicPreviewUrl,
  }) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        themeMusicArtistName: Value(newThemeMusicArtistName),
        themeMusicName: Value(newThemeMusicName),
        themeMusicImg: Value(newThemeMusicImg),
        themeMusicSpotifyUrl: Value(newThemeMusicSpotifyUrl),
        themeMusicPreviewUrl: Value(newThemeMusicPreviewUrl),
      ),
    );
  }

  Future updateLocalCommunityId(
      {required String uid, required String newCommunityId}) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        communityId: Value(newCommunityId),
      ),
    );
  }

  Future updateLocalUserProfileMsg(
      {required String uid, required String newUserProfileMsg}) {
    return (update(localUserProfiles)..where((tbl) => tbl.uid.equals(uid)))
        .write(
      LocalUserProfilesCompanion(
        userProfileMsg: Value(newUserProfileMsg),
      ),
    );
  }

  //UserProfileをLocalUserProfilesCompanionに変換する
  LocalUserProfilesCompanion changeUserProfileToLocalUserProfile(
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

  //----ユーザーの投稿----
  // ローカルDBから全てのLocalUserPostsをストリームとして取得する。
  // LocalUserPostsが追加、更新、削除されると、このストリームは新しいリストを返す。
  Stream<List<LocalUserPost>> watchAllLocalUserPosts() {
    return (select(localUserPosts)
          ..orderBy([
            (post) => OrderingTerm(
                expression: post.postTimestamp, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  // ローカルDBから全てのLocalUserPostを一度だけ取得する。
  Future<List<LocalUserPost>> getAllLocalUserPosts() {
    return (select(localUserPosts)
          ..orderBy([
            (post) => OrderingTerm(
                expression: post.postTimestamp, mode: OrderingMode.desc)
          ]))
        .get();
  }

  // 新しいLocalUserPostをローカルDBに挿入する。
  Future insertLocalUserPost(Post post) {
    return into(localUserPosts).insert(changePostToLocalUserPost(post));
  }

  // ローカルDBから任意のLocalUserProfileを削除する。
  Future deleteSpecificLocalUserPost(Post post) {
    return (delete(localUserPosts)..where((p) => p.postId.equals(post.postId)))
        .go();
  }

  // ローカルDBから全てのLocalUserProfileを削除する。
  Future deleteAllLocalUserPosts() {
    return delete(localUserPosts).go();
  }

  // PostをLocalUserPostsCompanionに変換する
  LocalUserPostsCompanion changePostToLocalUserPost(Post post) {
    return LocalUserPostsCompanion(
      uid: Value(post.uid),
      postId: Value(post.postId),
      postMusicImg: Value(post.postMusicImg),
      postMusicArtistName: Value(post.postMusicArtistName),
      postMusicName: Value(post.postMusicName),
      postMsg: Value(post.postMsg),
      postTimestamp: Value(post.postTimestamp),
      postMusicSpotifyUrl: Value(post.postMusicSpotifyUrl),
      postMusicPreciewUrl: Value(post.postMusicPreviewUrl),
    );
  }

  //----ユーザーのお気に入りアーティスト情報----
  // ローカルDBから全てのLocalUserFavoriteArtistsをストリームとして取得する。
  // LocalUserFavoriteArtistsが追加、更新、削除されると、このストリームは新しいリストを返す。
  Stream<List<LocalUserFavoriteArtist>> watchAllLocalUserFavoriteArtists() {
    return (select(localUserFavoriteArtists)).watch();
  }

  // ローカルDBから全てのLocalUserFavoriteArtistsを一度だけ取得する。
  Future<List<LocalUserFavoriteArtist>> getAllLocalUserFavoriteArtists() async {
    final query = select(localUserFavoriteArtists);
    final result = await query.get();
    if (result.isNotEmpty) {
      return result;
    } else {
      return [];
    }
  }

  // 新しいLocalUserFavoriteArtistをローカルDBに挿入する。
  Future insertLocalUserFavoriteArtist(Artist artist) {
    return into(localUserFavoriteArtists)
        .insert(changeArtistToLocalUserFavoriteArtist(artist));
  }

  // ローカルDBから任意のLocalUserFavoriteArtistを削除する。
  Future deleteSpecificLocalUserFavoriteArtist(Artist artist) {
    return (delete(localUserFavoriteArtists)
          ..where((a) => a.userFavoriteArtistId.equals(artist.artistSpotifyId)))
        .go();
  }

  // ローカルDBから全てのLocalUserFavoriteArtistsを削除する。
  Future deleteAllLocalUserFavoriteArtists() {
    return delete(localUserFavoriteArtists).go();
  }

  // PostをLocalUserPostsCompanionに変換する
  LocalUserFavoriteArtistsCompanion changeArtistToLocalUserFavoriteArtist(
      Artist artist) {
    return LocalUserFavoriteArtistsCompanion(
      userFavoriteArtistId: Value(artist.artistSpotifyId),
      userFavoriteArtistImg: Value(artist.artistImg),
      userFavoriteArtistName: Value(artist.artistName),
      userFavoriteArtistSpotifyUrl: Value(artist.spotifyArtistUrl),
    );
  }

  //----ユーザーのクイズ回答情報----
  // ローカルDBから全てのLocalUserPostAnswerをストリームとして取得する。
  // LocalUserPostAnswerが追加、更新、削除されると、このストリームは新しいリストを返す。
  Stream<List<LocalUserPostAnswer>> watchAllLocalUserPostAnswers() {
    return (select(localUserPostAnswers)).watch();
  }

  // ローカルDBから全てのLocalUserPostAnswersを一度だけ取得する。
  Future<List<LocalUserPostAnswer>> getAllLocalUserPostAnswers() async {
    final query = select(localUserPostAnswers);
    final result = await query.get();
    if (result.isNotEmpty) {
      return result;
    } else {
      return [];
    }
  }

  // 新しいLocalUserPostAnswerをローカルDBに挿入する。
  Future<void> insertLocalUserPostAnswer(PostAnswer postAnswer) async {
    try {
      await into(localUserPostAnswers)
          .insert(changePostAnswerToLocalUserPostAnswer(postAnswer));
    } catch (e) {
      print('insertLocalUserPostAnswer error: $e');
    }
  }

  // TODO ローカルDBから全てのLocalUserPostAnswersを削除する。
  Future<void> deleteAllLocalUserPostAnswers() async {
    await delete(localUserPostAnswers).go();
  }

  // TODO PostAnswerをLocalUserPostAnswersCompanionに変換する
  LocalUserPostAnswersCompanion changePostAnswerToLocalUserPostAnswer(
      PostAnswer postAnswer) {
    return LocalUserPostAnswersCompanion(
      postId: Value(postAnswer.postId),
      replyUid: Value(postAnswer.replyUid),
      replyUserName: Value(postAnswer.replyUserName),
      replyUserId: Value(postAnswer.replyUserId),
      replyUserImg: Value(postAnswer.replyUserImg),
      answerUid: Value(postAnswer.answerUid),
      posterUid: Value(postAnswer.posterUid),
      posterUserName: Value(postAnswer.posterUserName),
      posterUserImg: Value(postAnswer.posterUserImg),
      quizChoice1Uid: Value(postAnswer.quizChoice1Uid),
      quizChoice1UserName: Value(postAnswer.quizChoice1UserName),
      quizChoice1UserImg: Value(postAnswer.quizChoice1UserImg),
      quizChoice2Uid: Value(postAnswer.quizChoice2Uid),
      quizChoice2UserName: Value(postAnswer.quizChoice2UserName),
      quizChoice2UserImg: Value(postAnswer.quizChoice2UserImg),
      answerTimestamp: Value(postAnswer.answerTimestamp),
    );
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
