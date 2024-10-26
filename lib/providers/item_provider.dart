import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/item/item.dart';

final myItemsProvider = StateProvider<List<Item>>((ref) => []);
