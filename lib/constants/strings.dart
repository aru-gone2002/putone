import 'package:uuid/uuid.dart';

//button
const String accountExistBtnText = '既にアカウントをお持ちの方';
const String nextProgressBtnText = '次に進む';
const String tapForSettingBtnText = 'タップして設定';
const String skipBtnText = '後で登録';
const String registerBtnText = '登録';
const String searchBtnText = '検索';
const String backBtnText = '戻る';
const String accountNotExistBtnText = '会員登録する';
const String signInBtnText = 'ログイン';
const String signOutBtnText = 'ログアウト';
const String postBtnText = '投稿';
const String editBtnText = '編集';
const String changeBtnText = '変更';
const String followBtnText = 'フォロー';
const String followingBtnText = 'フォロー中';

//appbar
const String themeSongSettingPageAppbarTitle = 'テーマソングの登録';
const String setProfileMsgPageAppbarTitle = 'プロフィール文の登録';
const String setCommunityPageAppbarTitle = 'コミュニティの登録';
const String postCreatePageAppbarTitle = '投稿作成画面';
const String profileSettingAppbarTitle = 'プロフィール情報の登録';
const String editProfileAppbarTitle = 'プロフィール情報の編集';
const String editUserNameAppbarTitle = 'ユーザー名の変更';
const String editUserIdAppbarTitle = 'ユーザーIDの変更';
const String editThemeSongAppBarTitle = 'テーマソングの変更';
const String editCommunityAppBarTitle = 'コミュニティの変更';
const String editProfileMsgAppbarTitle = 'プロフィール文の変更';
const String homePageAppbarTitle = 'PuTone';
const String userSearchPageAppbarTitle = 'ユーザー検索';
const String artistFollowPageAppbarTitle = 'アーティスト';

//label
const String emailAddressLabel = "メールアドレス";
const String passwordLabel = "パスワード";
const String musicNameLabel = '楽曲名';
const String userIdLabel = 'ユーザーID';
const String userNameLabel = 'ユーザー名';
const String artistNameLabel = 'アーティスト名';
const String themeSongLabel = 'テーマソング';
const String profileMsgLabel = 'プロフィール文（80字以内)';
const String currentThemeSongLabel = '現在のテーマソング';
const String belongCommunityLabel = '所属コミュニティ';
const String selectedCommunityLabel = '選択したコミュニティ';
const String selectSongLabel = '曲の選択';
const String selectedSongLabel = '選択した曲';
const String currentUserNameLabel = '現在のユーザー名';
const String afterChangedUserNameLabel = '変更後のユーザー名';
const String currentUserIdLabel = '現在のユーザーId';
const String afterChangedUserIdLabel = '変更後のユーザーID';
const String currentCommunityLabel = '現在のコミュニティ';
const String afterChangedCommunityLabel = '変更後のコミュニティ';
const String currentProfileMsgLabel = '現在のプロフィール文';
const String afterChangedProfileMsgLabel = '変更後のプロフィール文（80字以内)';
const String resultOfSearchUserLabel = '検索の結果';
const String followerCountLabel = 'フォロワー';
const String followingCountLabel = 'フォロー中';

//title
const String signupTitle = '会員登録';
const String cropperTitle = 'Cropper';
const String profileTitle = 'プロフィール文';
const String signInTitle = 'ログイン';
const String userSearchTitle = 'ユーザー検索';

//text
const String emailAuthConfirmText = 'メールアドレス認証メールを\nお送りしましたのでご確認ください';
const String progressFirstProfileSettingText = 'プロフィール設定画面に進む';
const String weakPasswordText = 'パスワードが弱いです';
const String emailAlreadyInUseText = 'すでに使用されているメールアドレスです';
const String invalidEmailText = 'メールアドレスが無効です';
const String accountCreateErrorText = 'アカウント作成エラー';
const String signUpSucceededText = '会員登録に成功しました';
const String signInSucceededText = 'ログインに成功しました';
const String userNotFoundText = 'メールアドレスが見つかりません';
const String wrongPasswordText = 'パスワードが間違っています';
const String signInErrorText = 'ログインエラー';
const String errorAndRetryText = '何らかのエラーが発生しました。もう一度お試しください';
const String reSignUpText = '何らかのエラーが発生しました。もう一度会員登録画面に戻って、再度会員登録してください';
const String notInputEmailText = 'メールアドレスが入力されていません';
const String inputEmailIsNotValidText = '正しいメールアドレスを入力してください';
const String notInputPasswordText = 'パスワードが入力されていません';
const String inputPasswordIsNotValidText = '8文字以上で半角英数字記号をそれぞれ一文字以上ずつ入れてください';
const String notInputUserIdText = 'ユーザーIDが入力されていません';
const String inputUserIdIsNotValidText = '英小文字・数字・.・を組み合わせた4字以上16字以内で作成してください';
const String inputUserNameIsNotValidText = '1字以上16字以内で作成してください';
const String notInputUserNameText = 'ユーザー名が入力されていません';
const String isEmailVerifiedText = 'メールアドレス認証を完了済み';
const String emailIsNotVerifiedText =
    'メールアドレスが認証されていません。\nメールをご確認の上、再度メールアドレスを認証してください。';
const String missEmailAndreSignUpText = 'メールアドレスを間違えたため、再度会員登録する';
const String passwordRestrictionText = '半角英数字8文字以上';
const String userIdRestrictionText = '4文字以上。英小文字(a-z)、数字、ビリオド(.)が利用可。';
const String registerProfileImgText = 'プロフィール画像を登録';
const String askToSearchByTrackAndArtistText = '楽曲名とアーティスト名で検索してください';
const String setThemeMusicConfirmDialogText = '以下の楽曲をテーマソングに登録しますか？';
const String profileMsgHintText = '〇〇大学 ××学部';
const String askToSelectMusicText = '以下の楽曲から選択してください';
const String setCommunityConfirmDialogText = '以下のコミュニティを登録しますか？';
const String postMsgHintText = '今日の気分や曲への想い、ハマっている理由、おすすめポイントを書こう！';
const String noPostText = '投稿がありません';
const String themeSongIsNotSelectedText = 'テーマ曲未選択';
const String askToSettingThemeSongText = 'テーマ曲を選択してください';
const String editProfileImgText = 'プロフィール画像を編集';
const String editThemeMusicConfirmDialogText = '以下の楽曲にテーマソングを変更しますか？';
const String notRegisteredUserNameText = 'ユーザー名未登録';
const String notRegisteredUserIdText = 'ユーザーID未登録';
const String notRegisteredCommunityIdText = '所属：未所属';
const String notRegisteredProfileMsgText = 'プロフィール\nメッセージ\n未登録';
const String notExistProfileDataText = 'プロフィール情報が存在しません';
const String editCommunityConfirmDialogText = '以下のコミュニティに変更しますか？';
const String askToSearchByArtistText = 'アーティスト名で検索してください';

//hint text
const String writeArtistNameHintText = 'アーティスト名を入力';

//toast
const String userIdAndNameCompleteToastText = 'ユーザーIDとユーザー名の登録完了';
const String askToEnterTrackOrArtistToastText = '楽曲名かアーティスト名を入れてください';
const String saveProfileMsgToastText = 'プロフィール文が保存されました';
const String newPostSavedToastText = '投稿が保存されました';
const String changeProfileMsgToastText = 'プロフィール文が変更されました';
const String failToGetArtistInfoToastText = 'アーティスト情報が取得できませんでした';

//validator
const String notInputTextValidator = '文字が入力されていません';
const String askTextLengthLessThanOrEqual80Validator = '80字以下で入力してください';
const String askSelectCommunityValidator = 'コミュニティを選択してください';
const String askTextLengthLessThanOrEqual120Validator = '120字以下で入力してください';

//dialog title
const String askwhetherSignOutOrNotDialogTitle = 'ログアウトしますか？';

//error
const String failToReadDataErrorText = 'データの読み込みに失敗しました';

String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
