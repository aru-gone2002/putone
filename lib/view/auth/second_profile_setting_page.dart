import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';

class SecondProfileSettingPage extends ConsumerStatefulWidget {
  const SecondProfileSettingPage({super.key});

  @override
  ConsumerState<SecondProfileSettingPage> createState() {
    return _SecondProfileSettingPageState();
  }
}

class _SecondProfileSettingPageState
    extends ConsumerState<SecondProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileSettingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(child: Text('SecondProfileSettingPage')),
    );
  }
}
