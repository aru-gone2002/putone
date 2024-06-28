import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/view_model/auth_view_model.dart';

class AuthModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  // AuthViewModel _authViewModel = AuthViewModel();
  late UserCredential userCredential;

  Future<FirebaseAuthException?> signUpWithEmailAndPassword({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      final uid = userCredential.user!.uid;
      //_authViewModel.saveUid(uid);

      await userCredential.user!.sendEmailVerification();
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

  Future<bool> checkUserEmailVerified() async {
    final isEmailVerified = await userCredential.user!.emailVerified;
    return isEmailVerified;
  }

  Future<FirebaseAuthException?> signInWithEmailAndPassword({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'user-disabled') {
        print(invalidEmailText);
        return e;
      } else if (e.code == 'user-not-found') {
        print(userNotFoundText);
      } else if (e.code == 'wrong-password') {
        print(wrongPasswordText);
      } else {
        print(loginErrorText);
      }
    }
  }
}
