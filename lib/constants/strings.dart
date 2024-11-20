import 'package:uuid/uuid.dart';

//button
const String accountExistBtnText = 'Already have account';
const String nextProgressBtnText = 'Next';
const String tapForSettingBtnText = 'Tap for setting';
const String skipBtnText = 'Skip';
const String registerBtnText = 'Register';
const String searchBtnText = 'Search';
const String backBtnText = 'Back';
const String accountNotExistBtnText = 'Sign up';
const String signInBtnText = 'Sign in';
const String signOutBtnText = 'Sign out';
const String postBtnText = 'Post';
const String editBtnText = 'Edit';
const String changeBtnText = 'Change';
const String followBtnText = 'Follow';
const String followingBtnText = 'Following';
const String decideToYouBtnText = '君に決めた';
const String reconsiderBtnText = '考え直す...';
const String listenInSpotifyBtnText = 'Spotifyで聴く';

//appbar
const String themeSongSettingPageAppbarTitle = 'Set Theme Song';
const String setProfileMsgPageAppbarTitle = 'Set Profile';
const String setCommunityPageAppbarTitle = 'Set Community';
const String postCreatePageAppbarTitle = 'Create Post';
const String profileSettingAppbarTitle = 'Set Profile';
const String editProfileAppbarTitle = 'Edit Profile';
const String editUserNameAppbarTitle = 'Edit User Name';
const String editUserIdAppbarTitle = 'Edit User ID';
const String editThemeSongAppBarTitle = 'Edit Theme Song';
const String editCommunityAppBarTitle = 'Edit Community';
const String editProfileMsgAppbarTitle = 'Edit Profile Message';
const String homePageAppbarTitle = 'PuTone';
const String userSearchPageAppbarTitle = 'User Search';
const String artistFollowPageAppbarTitle = 'Musician';

//label
const String emailAddressLabel = "Email";
const String passwordLabel = "Password";
const String musicNameLabel = 'Music name';
const String userIdLabel = 'User ID';
const String userNameLabel = 'User name';
const String artistNameLabel = 'Musician name';
const String themeSongLabel = 'Theme song';
const String profileMsgLabel = 'Profile Message（Max 80 words)';
const String currentThemeSongLabel = 'Current theme song';
const String belongCommunityLabel = 'Community';
const String selectedCommunityLabel = 'Selected community';
const String selectSongLabel = 'Select song';
const String selectedSongLabel = 'Selected song';
const String currentUserNameLabel = 'Current user name';
const String afterChangedUserNameLabel = 'Changed user name';
const String currentUserIdLabel = 'Current user id';
const String afterChangedUserIdLabel = 'Changed user id';
const String currentCommunityLabel = 'Current community';
const String afterChangedCommunityLabel = 'Changed community';
const String currentProfileMsgLabel = 'Current Profile Message';
const String afterChangedProfileMsgLabel =
    'Changed profile message（max 80 words)';
const String resultOfSearchUserLabel = 'Search result';
const String followerCountLabel = 'Follower';
const String followingCountLabel = 'Following';

//title
const String signupTitle = 'Sign up';
const String cropperTitle = 'Cropper';
const String profileTitle = 'Profile message';
const String signInTitle = 'Sign in';
const String userSearchTitle = 'Search user';
const String finalAnswerTitle = 'Final Answer?';

//text
const String emailAuthConfirmText = 'メールアドレス認証メールを\nお送りしましたのでご確認ください';
const String progressFirstProfileSettingText = 'Progress Profile Setting Page';
const String weakPasswordText = 'Password is fragile';
const String emailAlreadyInUseText = 'This email is already used';
const String invalidEmailText = 'Email is invalid';
const String accountCreateErrorText = 'Error in creating account';
const String signUpSucceededText = 'Succeed in signing up';
const String signInSucceededText = 'Succeed in signing in';
const String userNotFoundText = 'Email is not found';
const String wrongPasswordText = 'Password is wrong';
const String signInErrorText = 'Error in signing in';
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
const String noFriendsText = 'No friends. \nLet\'s follow your friends!';
const String noFriendsPostText = '友達の投稿がありません';
const String answerPosterText = 'このユーザーが投稿者だと思う';

//hint text
const String writeArtistNameHintText = 'アーティスト名を入力';

//toast
const String userIdAndNameCompleteToastText = 'ユーザーIDとユーザー名の登録完了';
const String askToEnterTrackOrArtistToastText = '楽曲名かアーティスト名を入れてください';
const String saveProfileMsgToastText = 'プロフィール文が保存されました';
const String newPostSavedToastText = '投稿が保存されました';
const String changeProfileMsgToastText = 'プロフィール文が変更されました';
const String failToGetArtistInfoToastText = 'アーティスト情報が取得できませんでした';
const String failToOpenSpotifyLinkToastText = 'Could not open Spotify link';
const String failToGetPostAnswersToastText = '投稿への回答を取得中にエラーが発生しました';

//validator
const String notInputTextValidator = '文字が入力されていません';
const String askTextLengthLessThanOrEqual80Validator = '80字以下で入力してください';
const String askSelectCommunityValidator = 'コミュニティを選択してください';
const String askTextLengthLessThanOrEqual120Validator = '120字以下で入力してください';
const String userIdIsNotAvailableValidator = '既にこのuserIdは使用されています';

//dialog title
const String askwhetherSignOutOrNotDialogTitle = 'ログアウトしますか？';

//error
const String failToReadDataErrorText = 'データの読み込みに失敗しました';
const String failToGetFollowingUsersPostsErrorText = '友達の投稿取得中に何らかのエラーが発生しました';
const String somethingErrorText = '何らかのエラーが発生しました';

String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
