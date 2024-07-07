import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';

class ThemeSongSettingPage extends ConsumerStatefulWidget {
  const ThemeSongSettingPage({super.key});

  @override
  ConsumerState<ThemeSongSettingPage> createState() {
    return _ThemeSongSettingPageState();
  }
}

class _ThemeSongSettingPageState extends ConsumerState<ThemeSongSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(themeSongSettingPageAppbarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spaceWidthMedium),
        child: Column(children: []),
      ),
    );
  }
}
