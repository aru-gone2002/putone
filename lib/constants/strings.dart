import 'package:uuid/uuid.dart';

//button
const String accountExistBtnText = 'Already have account';
const String nextProgressBtnText = 'Next';
const String tapForSettingBtnText = 'Tap for setting';
const String skipBtnText = 'Skip';
const String registerBtnText = 'Register';
const String searchBtnText = 'Search';
const String backBtnText = 'Back';
const String signInBtnText = 'Sign in';
const String signOutBtnText = 'Sign out';
const String signUpBtnText = 'Sign up';
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
const String afterChangedUserNameLabel = 'changed user name';
const String currentUserIdLabel = 'Current user id';
const String afterChangedUserIdLabel = 'changed user id';
const String currentCommunityLabel = 'Current community';
const String afterChangedCommunityLabel = 'changed community';
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
const String emailAuthConfirmText =
    'We\'ve send you email address verification.\nPlease check your email';
// 'メールアドレス認証メールを\nお送りしましたのでご確認ください';
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
const String errorAndRetryText = 'Something went wrong. Please try again';
// '何らかのエラーが発生しました。もう一度お試しください';
const String reSignUpText = 'Something went wrong. Please sign up again';
// '何らかのエラーが発生しました。もう一度会員登録画面に戻って、再度会員登録してください';
const String notInputEmailText = 'Email is not entered';
// 'メールアドレスが入力されていません';
const String inputEmailIsNotValidText = 'Please enter a valid email address';
// '正しいメールアドレスを入力してください';
const String notInputPasswordText = 'Password is not entered';
// 'パスワードが入力されていません';
const String inputPasswordIsNotValidText =
    'Please enter at least 8 characters,\nincluding at least one letter and one number';
// '8文字以上で半角英数字記号をそれぞれ一文字以上ずつ入れてください';
const String notInputUserIdText = 'User ID is not entered';
// 'ユーザーIDが入力されていません';
const String inputUserIdIsNotValidText =
    'Please create a string that is 4 to 16 characters long,\nusing only lowercase letters, numbers, and periods.';
//'英小文字・数字・.・を組み合わせた4字以上16字以内で作成してください';
const String inputUserNameIsNotValidText =
    'Please create a string that is 1 to 16 characters long.';
// '1字以上16字以内で作成してください';
const String notInputUserNameText = 'User name is not entered';
// 'ユーザー名が入力されていません';
const String isEmailVerifiedText = 'Email address verification \nis complete';
// 'メールアドレス認証を完了済み';
const String emailIsNotVerifiedText =
    'Your email address has not been verified.\nPlease check your email and verify your email address again.';
//'メールアドレスが認証されていません。\nメールをご確認の上、再度メールアドレスを認証してください。';
const String missEmailAndreSignUpText =
    'I made a mistake with my email address,\nso I need to re-register.';
//'メールアドレスを間違えたため、再度会員登録する';
const String passwordRestrictionText =
    'Please enter at least 8 alphanumeric characters.';
//'半角英数字8文字以上';
const String userIdRestrictionText =
    'Please enter at least 4 characters.\nLowercase letters (a-z), numbers, and periods (.) are allowed.';
//'4文字以上。英小文字(a-z)、数字、ビリオド(.)が利用可。';
const String registerProfileImgText = 'Register profile image';
//'プロフィール画像を登録';
const String askToSearchByTrackAndArtistText =
    'Please search by song title and musician name.';
//'楽曲名とアーティスト名で検索してください';
const String setThemeMusicConfirmDialogText =
    'Would you like to set this song as your theme song?';
//'以下の楽曲をテーマソングに登録しますか？';
const String profileMsgHintText =
    'I\'m a student at XX University. A fan of XX.';
// '〇〇大学 ××学部';
const String askToSelectMusicText = 'Please select from the following songs.';
//'以下の楽曲から選択してください';
const String setCommunityConfirmDialogText =
    'Would you like to register the following community?';
//'以下のコミュニティを登録しますか？';
const String postMsgHintText =
    'Let\'s write about how you feel today, what you think about the song, or why you\'re into it!';
//'今日の気分や曲への想い、ハマっている理由、おすすめポイントを書こう！';
const String noPostText = 'No posts';
//'投稿がありません';
const String themeSongIsNotSelectedText = 'Theme song is not selected';
// 'テーマ曲未選択';
const String askToSettingThemeSongText = 'Please set your theme song';
//'テーマ曲を選択してください';
const String editProfileImgText = 'Edit profile image';
// 'プロフィール画像を編集';
const String editThemeMusicConfirmDialogText =
    'Would you like to change the theme song to the following song?';
// '以下の楽曲にテーマソングを変更しますか？';
const String notRegisteredUserNameText = 'User name is not registered';
// 'ユーザー名未登録';
const String notRegisteredUserIdText = 'User ID is not registered';
// 'ユーザーID未登録';
const String notRegisteredProfileMsgText = 'Profile message\nis not registered';
//'プロフィール\nメッセージ\n未登録';
const String editCommunityConfirmDialogText =
    'Would you like to change the community to the following?';
//'以下のコミュニティに変更しますか？';
const String askToSearchByArtistText = 'Please search by musician name';
//'アーティスト名で検索してください';
const String noFriendsText = 'No friends. \nLet\'s follow your friends!';
const String noFriendsPostText =
    'No friends\' posts. \nLet\'s follow your friends!';

//hint text
const String writeArtistNameHintText = 'Enter musician name';
// 'アーティスト名を入力';

//toast
const String userIdAndNameCompleteToastText =
    'User ID and user name registered';
//'ユーザーIDとユーザー名の登録完了';
const String askToEnterTrackOrArtistToastText =
    'Enter song title or musician name';
// '楽曲名かアーティスト名を入れてください';
const String saveProfileMsgToastText = 'Profile message saved';
//'プロフィール文が保存されました';
const String newPostSavedToastText = 'Post saved';
// '投稿が保存されました';
const String changeProfileMsgToastText = 'Profile message changed';
// 'プロフィール文が変更されました';
const String failToGetArtistInfoToastText = 'Failed to get musician data';
// 'アーティスト情報が取得できませんでした';
const String failToOpenSpotifyLinkToastText = 'Could not open Spotify link';

//validator
const String notInputTextValidator = 'Text is not entered';
//'文字が入力されていません';
const String askTextLengthLessThanOrEqual80Validator =
    'Please enter less than 80 characters.';
//'80字以下で入力してください';
const String askSelectCommunityValidator = 'Select community';
const String askTextLengthLessThanOrEqual120Validator =
    'Please enter less than 120 characters.';
const String userIdIsNotAvailableValidator = 'This user ID is already in use';
// /'既にこのuserIdは使用されています';

//dialog title
const String askwhetherSignOutOrNotDialogTitle = 'Sign out?';
// 'ログアウトしますか？';

//error
const String failToReadDataErrorText = 'Failed to read data';
// 'データの読み込みに失敗しました';
const String failToGetFollowingUsersPostsErrorText =
    'Failed to get following users posts';
//'友達の投稿取得中に何らかのエラーが発生しました';
const String somethingErrorText = 'Something went wrong';
//'何らかのエラーが発生しました';

String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
