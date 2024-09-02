import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/providers/bottom_navigation_bar_provider.dart';

class BottomNavigationBarViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  int get bottomNavigationBarCurrentIndex =>
      _ref.watch(bottomNavigationCurrentIndexProvider);

  void saveBottomNavigationBarCurrentIndex(int value) {
    _ref.read(bottomNavigationCurrentIndexProvider.notifier).state = value;
  }
}
