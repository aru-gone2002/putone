import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/providers/item_provider.dart';

class ItemViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  List<Item> get items => _ref.watch(myItemsProvider);
}
