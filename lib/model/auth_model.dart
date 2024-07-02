import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:putone/constants/strings.dart';

class AuthModel {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseAuthException?> signUpWithEmailAndPassword({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      //final uid = userCredential.user!.uid;
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

  Future<void> signOut() async {
    await auth.signOut();
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
