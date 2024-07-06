import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/putone.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //-----AppCheckの初期化コード-----//
  // await FirebaseAppCheck.instance.activate(
  //   appleProvider:
  //       kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  //   androidProvider:
  //       kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
  // );
  //------------------------------//
  runApp(const ProviderScope(child: PuTone()));
}
