import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/local_database.dart';
import 'package:putone/providers/user_profile_provider.dart';

class LocalDatabaseViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  AppDatabase? get appDatabase => _ref.watch(appDataBaseProvider);

  void saveAppDatabase(AppDatabase value) {
    _ref.read(appDataBaseProvider.notifier).state = value;
  }

  // 追加: プロバイダーからuidを取得するメソッド
  String? getUidFromProvider() {
    final userProfile = _ref.read(userProfileProvider);
    return userProfile?.uid;
  }
}
