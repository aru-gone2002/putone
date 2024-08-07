import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/model/auth_model.dart';
import 'package:putone/providers/user_auth_provider.dart';
import 'package:putone/providers/user_profile_provider.dart';

class AuthViewModel {
  final AuthModel _authModel = AuthModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  String get uid => _ref.watch(userAuthProvider.select((value) => value.uid));

  String get userEmail =>
      _ref.watch(userAuthProvider.select((value) => value.userEmail));

  String get userPassword =>
      _ref.watch(userAuthProvider.select((value) => value.userPassword));

  bool get userEmailVerified =>
      _ref.watch(userAuthProvider.select((value) => value.userEmailVerified));

  bool get signUpIsLoading => _ref.watch(signUpIsLoadingProvider);

  bool get signInIsLoading => _ref.watch(signInIsLoadingProvider);

  bool get emailAuthIsLoading => _ref.watch(emailAuthIsLoadingProvider);

  UserProfile get userProfile => _ref.read(userProfileProvider);

  void saveUid(String value) {
    _ref.read(userAuthProvider.notifier).state =
        _ref.read(userAuthProvider).copyWith(uid: value);
  }

  void saveEmail(String value) {
    _ref.read(userAuthProvider.notifier).state =
        _ref.read(userAuthProvider).copyWith(userEmail: value);
  }

  void savePassword(String value) {
    _ref.read(userAuthProvider.notifier).state =
        _ref.read(userAuthProvider).copyWith(userPassword: value);
  }

  void saveEmailVerified(bool value) {
    _ref.read(userAuthProvider.notifier).state =
        _ref.read(userAuthProvider).copyWith(userEmailVerified: value);
  }

  void loadingSignUp() {
    _ref.read(signUpIsLoadingProvider.notifier).state = true;
  }

  void completedSignUp() {
    _ref.read(signUpIsLoadingProvider.notifier).state = false;
  }

  void loadingSignIn() {
    _ref.read(signInIsLoadingProvider.notifier).state = true;
  }

  void completedSignIn() {
    _ref.read(signUpIsLoadingProvider.notifier).state = false;
  }

  void loadingEmailAuth() {
    _ref.read(emailAuthIsLoadingProvider.notifier).state = true;
  }

  void completedEmailAuth() {
    _ref.read(emailAuthIsLoadingProvider.notifier).state = false;
  }

  Future<FirebaseException?> signUpWithEmailAndPassword() async {
    final response = await _authModel.signUpWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
      userProfile: userProfile,
      ref: _ref,
    );

    return response;
  }

  Future<FirebaseException?> signInWithEmailAndPassword() async {
    final response = await _authModel.signInWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
    );
    //profileViewModelのsaveUidでuidをuser_profile_providerに入れる。

    return response;
  }

  Future<void> sendEmailVerification() async {
    await _authModel.sendEmailVerification();
  }

  Future<void> checkUserEmailVerified() async {
    final emailVerified = await _authModel.checkUserEmailVerified();
    saveEmailVerified(emailVerified);
  }

  Future<void> signOut() async {
    _authModel.signOut();
  }

  Future<void> checkUid() async {
    final uid = _authModel.checkUid();
    saveUid(uid);
  }
}
