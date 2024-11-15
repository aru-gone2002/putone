import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/view_model/community_view_model.dart';
import 'package:putone/view_model/profile_view_model.dart';

class CommunityPage extends ConsumerWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel profileViewModel = ProfileViewModel();
    final CommunityViewModel communityViewModel = CommunityViewModel();
    profileViewModel.setRef(ref);

    return Center(
      child: ElevatedButton(
          onPressed: () async {
            final result = await communityViewModel.getCommunityUsers(
                communityId: profileViewModel.communityId);
            if (result == null) {
              print('fail to get community users');
            }
            if (result != null && result.isEmpty) {
              print('No community users');
            }
            if (result != null && result.isNotEmpty) {
              print(result);
            }
          },
          child: const Text('getCommunityUsers')),
    );
  }
}
