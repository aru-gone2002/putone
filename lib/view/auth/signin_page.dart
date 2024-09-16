import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/routes.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/accent_color_button.dart';
import 'package:putone/view/item/form_field_item.dart';
import 'package:putone/view/item/gray_color_text_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final PostViewModel _postViewModel = PostViewModel();
  final LocalDatabaseViewModel _localDatabaseViewModel =
      LocalDatabaseViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInFunction(
      GlobalObjectKey<FormState> formKey, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //firebase Authでメールアドレスとパスワードを使ってサインインする
      //isSignInをtrueにする。
      final signInResponse = await _authViewModel.signInWithEmailAndPassword();

      if (signInResponse is FirebaseAuthException) {
        await Fluttertoast.showToast(
            msg: switch (signInResponse.code) {
          'invalid-email' || 'user-disabled' => invalidEmailText,
          'user-not-found' => userNotFoundText,
          'wrong-password' => wrongPasswordText,
          _ => signInErrorText,
        });
      }

      //----サインインが成功時----
      if (signInResponse == null) {
        await Fluttertoast.showToast(msg: signInSucceededText);
        //uidをuser_auth_providerに格納する
        _authViewModel.checkUid();
        //uidをuser_profile_providerに格納する
        _profileViewModel.saveUid(_authViewModel.uid);
        //メールアドレスが認証されているかをチェックする
        await _authViewModel.checkUserEmailVerified();
        //----メールアドレスが認証されているかで遷移先を変更----
        if (_authViewModel.userEmailVerified) {
          //自分のプロフィール情報をFirestoreから取得し、user_profile_providerに格納
          await _profileViewModel.getUserProfile(_authViewModel.uid);
          print('getUserProfileをしました');
          //TODO 自分の投稿をFirestoreから取得し、post_providerに格納する
          final userPosts =
              await _postViewModel.getUserPosts(_authViewModel.uid);
          if (userPosts != null) {
            _postViewModel.insertPostsToList(userPosts);
            for (var userPost in userPosts) {
              await _localDatabaseViewModel.appDatabase!
                  .insertLocalUserPost(userPost);
            }
          }
          //UserProfileProviderに入っている情報をデータベースに入れる。
          //appDatabaseにAppDatabaseのインスタンスが現状入っていないため、事前に入れる → AuthPageが表示されたときに格納している
          await _localDatabaseViewModel.appDatabase!
              .insertLocalUserProfile(_profileViewModel.userProfile);
          print('insertUserBaseProfileをしました');
          if (context.mounted) {
            //この段階では既にAppDatabaseのインスタンスはproviderに格納されている。
            toAfterSignInPage(context: context);
          }
        } else {
          if (context.mounted) {
            toEmailAuthPage(context: context);
          }
          await _authViewModel.sendEmailVerification();
        }
      } else {
        _authViewModel.refreshFromSignInAndSignOut();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authViewModel.setRef(ref);
    _profileViewModel.setRef(ref);
    _postViewModel.setRef(ref);
    _localDatabaseViewModel.setRef(ref);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalObjectKey<FormState>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 100),
          Text(
            signInTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FormFieldItem(
                  autovalidateMode: null,
                  controller: _emailController,
                  maxLength: maxEmailTextLength,
                  itemName: emailAddressLabel,
                  textRestriction: '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputEmailText;
                    }
                    if (!RegExp(
                      caseSensitive: false,
                      r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
                      //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return inputEmailIsNotValidText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authViewModel.saveEmail(value as String);
                  },
                ),
                FormFieldItem(
                  autovalidateMode: null,
                  controller: _passwordController,
                  maxLength: maxPasswordTextLength,
                  itemName: passwordLabel,
                  textRestriction: '',
                  //TODO validatorは緩くする
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return notInputPasswordText;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authViewModel.savePassword(value as String);
                  },
                ),

                const SizedBox(height: 60),
                //isLoadingでグルグルさせる
                Visibility(
                  visible: !_authViewModel.signInIsLoading,
                  replacement: SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColorTheme.color().accentColor,
                      ),
                    ),
                  ),
                  child: AccentColorButton(
                    //loadingSignInメソッドをauthViewModelに作成
                    //メールアドレスとパスワードを使って、FirebaseAuthでログインする
                    //メールアドレスが認証されていなかったらメールアドレスを認証する画面を表示させる
                    //ユーザーのプロフィール情報を取得する
                    //completedSignInメソッドをauthViewModelに作成
                    onPressed: () async {
                      _authViewModel.loadingSignIn();
                      await signInFunction(formKey, ref);
                      _authViewModel.completedSignIn();
                    },
                    text: signInBtnText,
                  ),
                ),
                const SizedBox(height: 32),
                GrayColorTextButton(
                  onPressed: () => toSignUpPage(context: context),
                  text: accountNotExistBtnText,
                ),
                //TODO パスワードを再発行するボタンを作成する
              ],
            ),
          )
        ]),
      ),
    );
  }
}
