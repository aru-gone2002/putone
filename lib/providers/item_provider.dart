import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/item/item.dart';

final userItemsProvider = StateProvider<List<Item>>((ref) => []);
