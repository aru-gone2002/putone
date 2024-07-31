import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/community/community.dart';

final communityMapProvider = StateProvider<Map<String, Community>>((ref) => {
      'rikadai': Community(
        communityId: 'rikadai',
        communityName: '東京理科大学',
        communityMemberUids: [],
      ),
      'musashino': Community(
        communityId: 'musashino',
        communityName: '武蔵野大学',
        communityMemberUids: [],
      ),
      'toudai': Community(
        communityId: 'toudai',
        communityName: '東京大学',
        communityMemberUids: [],
      ),
      'none': Community(
        communityId: 'none',
        communityName: '未参加',
        communityMemberUids: [],
      ),
    });

final selectedCommunityProvider = StateProvider<Community>(
  (ref) => const Community(
    communityId: 'none',
    communityName: '未参加',
    communityMemberUids: [],
  ),
);
