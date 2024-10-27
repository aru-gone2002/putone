import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/item/item.dart';

final myItemsProvider = StateProvider<List<Item>>((ref) => []);

final temporaryItemProvider = StateProvider<Item>(
  (ref) => Item(
    uid: '',
    itemId: '',
    isForSale: false,
    artistSpotifyId: '',
    artistName: '',
    artistSpotifyUrl: '',
    itemImgs: ['', '', '', ''],
    itemName: '',
    itemDiscription: '',
    price: 0,
    size: '',
    categories: [],
    createdAt: DateTime.now(),
  ),
);
