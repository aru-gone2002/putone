import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/model/user_search_model.dart';
import 'package:putone/providers/user_serach_provider.dart';

class UserSearchViewModel {
  final UserSearchModel _searchModel = UserSearchModel();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  bool get isUserSearching => _ref.watch(isUserSearchingProvider);

  void searchingUser() {
    _ref.read(isUserSearchingProvider.notifier).state = true;
  }

  void completedSearchingUser() {
    _ref.read(isUserSearchingProvider.notifier).state = false;
  }

  Future<dynamic> searchUserByUserId(String searchUserId) async {
    final result = await _searchModel.searchUserByUserId(searchUserId);
    return result;
  }
}
