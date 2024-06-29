import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';

class FirstProfileSettingPage extends ConsumerStatefulWidget {
  const FirstProfileSettingPage({super.key});

  @override
  ConsumerState<FirstProfileSettingPage> createState() {
    return _FirstProfileSettingPageState();
  }
}

class _FirstProfileSettingPageState
    extends ConsumerState<FirstProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileSettingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(child: Text('プロフィール設定画面')),
    );
  }
}
