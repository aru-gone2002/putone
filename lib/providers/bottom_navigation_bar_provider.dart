import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view/home/home_page.dart';
import 'package:putone/view/profile/profile_page.dart';

final bottomNavigationCurrentIndexProvider = StateProvider<int>((ref) => 0);

// final bottomNavigationWidgetsProvider = StateProvider<List<Widget>>((ref) => [
//   HomePage(),
//   ProfilePage(database: database);
// ]);
