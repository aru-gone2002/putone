import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/user_auth/user_auth.dart';

final userAuthProvider = StateProvider<UserAuth>(
  (ref) => const UserAuth(
    uid: '',
    userEmail: '',
    userPassword: '',
    userEmailVerified: false,
  ),
);

final signUpIsLoadingProvider = StateProvider<bool>((ref) => false);

final emailAuthIsLoadingProvider = StateProvider<bool>((ref) => false);
