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

//appbar
const String themeSongSettingPageAppbarTitle = 'テーマソングの登録';
const String profileMsgSettingPageAppbarTitle = 'プロフィール文の登録';
const String communityPageAppbarTitle = 'コミュニティの登録';

//label
const String emailAddressLabel = "メールアドレス";
const String passwordLabel = "パスワード";
const String musicNameLabel = '楽曲名';
const String userIdLabel = 'ユーザーID';
const String userNameLabel = 'ユーザー名';
const String artistNameLabel = 'アーティスト名';
const String themeSongLabel = 'テーマソング';
const String profileMsgLabel = 'プロフィール文（120字以内)';
const String selectedThemeSongLabel = '選択したテーマソング';
const String belongCommunityLabel = '所属コミュニティ';
const String selectedCommunityLabel = '選択したコミュニティ';

//title
const String signupTitle = '会員登録';
const String profileSettingTitle = 'プロフィール情報の登録';
const String cropperTitle = 'Cropper';
const String profileTitle = 'プロフィール文';
const String signInTitle = 'ログイン';

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
const String inputUserIdIsNotValidText = '小文字の英語・数字・.・_を組み合わせた4文字以上で作成してください';
const String notInputUserNameText = 'ユーザー名が入力されていません';
const String isEmailVerifiedText = 'メールアドレス認証を完了済み';
const String emailIsNotVerifiedText =
    'メールアドレスが認証されていません。\nメールをご確認の上、再度メールアドレスを認証してください。';
const String missEmailAndreSignUpText = 'メールアドレスを間違えたため、再度会員登録する';
const String passwordRestrictionText = '半角英数字8文字以上';
const String userIdRestrictionText = '4文字以上。英小文字(a-z)、数字、ビリオド(.)が利用可。';
const String registerProfileImgText = 'プロフィール画像を登録';
const String askToSearchByTrackAndArtistText = '楽曲名とアーティスト名で検索してください';
const String musicSettingConfirmDialogText = '以下の楽曲をテーマソングに登録しますか？';
const String profileMsgHintText = '〇〇大学 ××学部';
const String askToSelectMusicText = '以下の楽曲から選択してください';
const String communitySettingConfirmDialogText = '以下のコミュニティを登録しますか？';

//snackBar
const String userIdAndNameCompleteSnackBarText = 'ユーザーIDとユーザー名の登録完了';
const String askToEnterTrackOrArtistSnackBarText = '楽曲名かアーティスト名を入れてください';
const String profileMsgSavedSnackBarText = 'プロフィール文が保存されました';

//validator
const String notInputTextValidator = '文字が入力されていません';
const String askTextLengthLessThanOrEqual80Validator = '80字以下で入力してください';
const String askSelectCommunityValidator = 'コミュニティを選択してください';

//dialog title
const String askwhetherSignOutOrNotDialogTitle = 'ログアウトしますか？';

//error
const String failToReadDataErrorText = 'データの読み込みに失敗しました';

String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
