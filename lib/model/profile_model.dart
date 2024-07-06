import 'package:firebase_auth/firebase_auth.dart';

class ProfileModel {
  FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    final uid = auth.currentUser!.uid;
    return uid;
  }
}
