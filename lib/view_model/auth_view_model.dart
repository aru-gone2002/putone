import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/model/auth_model.dart';
import 'package:putone/providers/user_auth_provider.dart';

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

  Future<FirebaseException?> signUpWithEmailAndPassword() async {
    final response = await _authModel.signUpWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    return response;
  }

  Future<FirebaseException?> signInWithEmailAndPassword() async {
    final response = await _authModel.signInWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
    );
    final uid = _authModel.checkUid();
    saveUid(uid);
    return response;
  }

  Future<void> checkUserEmailVerified() async {
    final emailVerified = await _authModel.checkUserEmailVerified();
    saveEmailVerified(emailVerified);
  }

  Future signOut() async {
    _authModel.signOut();
  }
}
