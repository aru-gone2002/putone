import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemsMarketPage extends ConsumerStatefulWidget {
  const ItemsMarketPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ItemsMarketPage> createState() => _ItemsMarketPageState();
}

class _ItemsMarketPageState extends ConsumerState<ItemsMarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Items Market Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
