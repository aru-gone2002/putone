import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:putone/constants/strings.dart';
import 'package:putone/data/user_profile/user_profile.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class AuthModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> signUpWithEmailAndPassword({
    required String userEmail,
    required String userPassword,
    required UserProfile userProfile,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(weakPasswordText);
        return e;
      } else if (e.code == 'email-already-in-use') {
        print(emailAlreadyInUseText);
        return e;
      } else if (e.code == 'invalid-email') {
        print(invalidEmailText);
        return e;
      } else {
        print(accountCreateErrorText);
        return e;
      }
    }
  }

  Future<FirebaseAuthException?> signInWithEmailAndPassword({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'user-disabled') {
        print(invalidEmailText);
        return e;
      } else if (e.code == 'user-not-found') {
        print(userNotFoundText);
      } else if (e.code == 'wrong-password') {
        print(wrongPasswordText);
      } else {
        print(signInErrorText);
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Future<bool> checkUserEmailVerified() async {
    await auth.currentUser!.reload();
    final emailVerified = auth.currentUser!.emailVerified;
    return emailVerified;
  }

  String checkUid() {
    final uid = auth.currentUser!.uid;
    return uid;
  }
}
